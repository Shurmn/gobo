extends GutTest

# Fake subber with stubbed callback
class FakeListener:
	extends Node
	var called := false
	var event_received: Event = null
	
	func callback_function(event: Event):
		called = true
		event_received = event

var bus: EventBus
var listener: FakeListener

func before_each():
	bus = EventBus.new()
	listener = FakeListener.new()
	
func test_subscribe_adds_correctly():
	bus.subscribe("fake_event", listener, "callback_function")
	
	assert_true(bus.registry.has("fake_event"))
	assert_eq(bus.registry["fake_event"].size(), 1)
	
	var subs = bus.registry["fake_event"]
	assert_eq(subs[0].event_id, "fake_event")
	assert_eq(subs[0].subscriber, listener)
	assert_eq(subs[0].function_name, "callback_function" )
	
func test_subscribe_does_not_duplicate():
	bus.subscribe("fake_event", listener, "callback_function")
	bus.subscribe("fake_event", listener, "callback_function")
	
	assert_eq(bus.registry["fake_event"].size(), 1)
	
func test_post_callback():
	var event := Event.new("fake_event")
	
	bus.subscribe("fake_event", listener, "callback_function")
	bus.post(event)
	
	assert_true(listener.called)
	assert_eq(listener.event_received, event)
	
func test_post_skips_invalid_subscriber():
	var event := Event.new("fake_event")
	
	bus.subscribe("fake_event", listener, "callback_function")
	listener.free()
	
	bus.post(event)
	
	assert_eq(bus.registry["fake_event"].size(), 0)
	
func test_post_skips_missing_function():
	var event := Event.new("fake_event")
	
	bus.subscribe("fake_event", listener, "not_a_function")
	bus.post(event)
	
	assert_true(not listener.called)
	
func test_is_already_registered():
	var sub_a := EventSubscription.new("match", listener, "callback_function")
	var sub_b := EventSubscription.new("match", listener, "callback_function")
	var sub_c := EventSubscription.new("match", listener, "other_function")
	
	assert_true(bus._is_already_registered(sub_a, sub_b))
	assert_true(not bus._is_already_registered(sub_a, sub_c))
	
func test_remove_invalid_subscription():
	var sub := EventSubscription.new("fake_event", listener, "callback_function")
	var subs = [sub]
	
	bus.registry["fake_event"] = subs
	assert_eq(subs.size(), 1)
	
	bus._remove_invalid_subscription("fake_event", subs, sub)
	
	assert_eq(subs.size(), 0)
	assert_true(bus.registry.has("fake_event"))
	
