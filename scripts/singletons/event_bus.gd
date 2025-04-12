class_name EventBus
extends Node

# https://github.com/BajaTheFrog/godot-event-bus/blob/main/addons/event_bus/event_bus_service.gd

# we will need a dictionary of events-to-subs, to track who wants which call-backs
# each key will be an event id, and the value will be a list of subscribers to that event
# nodes will subscribe by putting their refs on the lists of events they care about:
# 	Ex: EventBus.subscribe(game_paused, self, pause)
# nodes can trigger events, and we'll call the functions of every subscriber:
#	Ex: EventBus.trigger(game_paused)

@onready var registry: Dictionary = {}

# nodes will register to be notified
func subscribe(event_id, subscriber: Object, function_name: String) -> void:
	var new_subscription = EventSubscription.new(event_id, subscriber, function_name)
	_register(new_subscription)

# call the function of every subscriber in registry[event.event_id]
func trigger(event: Event) -> void:
	var id = event.event_id
	if id in registry:
		var event_subs: Array = registry[id]
		for sub in event_subs:
			var subscriber = sub.subscriber
			if not is_instance_valid(subscriber):
				_remove_invalid_subscription(id, event_subs, sub)
				continue
				
			var fn = sub.function_name
			if not subscriber.has_method(fn):
				continue
			
			subscriber.call(fn, event)
	
# a private register method will process the incoming subscription request
func _register(new_subscription: EventSubscription) -> void:
	var id = new_subscription.event_id
	
	if not id in registry:
		registry[id] = [new_subscription]
	else:
		var event_subs = registry[id]
		for sub in event_subs:
			if _is_already_registered(new_subscription, sub):
				return
	
		event_subs.append(new_subscription)
		registry[id] = event_subs

# pull expression logic out for readability and to make testing easier
func _is_already_registered(incoming_sub: EventSubscription, existing_sub: EventSubscription) -> bool:
	return (incoming_sub.subscriber == existing_sub.subscriber 
		and incoming_sub.function_name == existing_sub.function_name)

# if we find a sub reference has gone bad, remove it. garbage collection demands bytes
func _remove_invalid_subscription(id, event_subs: Array, invalid_sub: EventSubscription):
	var index: int = event_subs.find(invalid_sub)
	if index >= -1:
		event_subs.remove_at(index)
	registry[id] = event_subs
