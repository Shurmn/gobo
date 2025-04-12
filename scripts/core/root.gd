class_name Root
extends Node

# scene boss
# listen to the state machine
# manage global event casting and subs

@onready var state_machine := get_children().find(StateMachine)
@onready var node_data := get_children().find(Data)
