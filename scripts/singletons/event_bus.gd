class_name EventBus
extends Node

# https://github.com/BajaTheFrog/godot-event-bus/blob/main/addons/event_bus/event_bus_service.gd

# need a dictionary of events to subs
@onready var registry = Dictionary()

# nodes will register to be notified
func subscribe(event_id, subscriber: Object, function_name: String) -> void:
	var subscription = EventSubscription.new(event_id, subscriber, function_name)
	_register(subscription)
	
func cast(event: Event) -> void:
	var id = event.event_name
	if id in registry:
		var event_subs = registry[id]
		for sub in event_subs:
			var subscriber = sub.subscriber
			if not is_instance_valid(subscriber):
				_remove_invalid_subscription(id, event_subs, sub)
				continue
				
			var fn = sub.function_name
			if not subscriber.has_method(fn):
				continue
			
			subscriber.call(fn, event)
	
func _register(new_subscription: EventSubscription) -> void:
	var id = new_subscription.event_id
	var fn = new_subscription.function_name
	
	if not id in registry:
		registry[id] = [new_subscription]
	else:
		var event_subs = registry[id]
		for sub in event_subs:
			if _is_already_registered(new_subscription, sub):
				return
	
		event_subs.append(new_subscription)
		registry[id] = event_subs
		
func _is_already_registered(incoming_sub: EventSubscription, existing_sub: EventSubscription) -> bool:
	return (incoming_sub.subscriber == existing_sub.subscriber 
		and incoming_sub.function_name == existing_sub.function_name)
		
func _remove_invalid_subscription(id, event_subs: List, invalid_sub: EventSubscription):
	var index = event_subs.find(invalid_sub)
	if index >= 0:
		event_subs.remove
	registry[id] = event_subs
