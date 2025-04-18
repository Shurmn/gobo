class_name AnimationStateMachine
extends StateMachine

@onready var animation: AnimatedSprite2D  = _resolve_animation()

func _ready() -> void:
	for child in get_children():
		if child is AnimationState:
			child.state_wants_to_change.connect(_change_state)
			child.set_animation(animation)
			states[child.name] = child
	awaken()
	
func _resolve_animation() -> AnimatedSprite2D:
	return find_child("*Animation")
