class_name Root
extends Node

# scene boss
# listen to the state machine
# manage global event casting and subs
# manage data

@onready var state_machine: StateMachine = _resolve_state_machine() 

func _resolve_state_machine() -> StateMachine:
	for child in get_children():
		if child is StateMachine:
			return child
	return null

func _ready() -> void:
	pass 
