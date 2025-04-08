class_name State
extends Node

# the state wants to change
signal state_aspires_to(desired_state: String)

# the stator will give us unhandled inputs from this chute
func handle_input(event: InputEvent) -> void:
	pass

# we don't want to use _process, that's for the stator to decide
func update(_delta: float) -> void:
	pass

# same idea, let the stator control when this happens	
func physics_update(_delta: float) -> void:
	pass

# for init things, lookin at you animation
func on_enter() -> void:
	pass

# dont let the door hit ya
func on_exit() -> void:
	pass
