class_name AnimationState
extends State

@export var enter_animation: String = "idle"
var animation: AnimatedSprite2D

func set_animation(animation: AnimatedSprite2D) -> void:
	self.animation = animation

func on_enter() -> void:
	animation.play(enter_animation)
