class_name EventSubscription
extends RefCounted

var event_id: String
var subscriber: Object
var function_name: String

func _init(id, sub: Object, function) -> void:
	self.event_id = id
	self.subscriber = sub
	self.function_name = function
