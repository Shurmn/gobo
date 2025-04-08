class_name Stator
extends Node

# what can we be
var states = {}

# what have we been
var history = []

# how we begin
var initial_state: State

# what are we now
@onready var current_state: State = get_initial_state()

# init not set but that's null good dawg we'll just go for the first child State
func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)

# connect to the state_aspires_to signal of all child states, add them to states
func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_aspires_to.connect(_on_state_shift)
			states[child.name] = child
	await owner.ready
	current_state.on_enter()

func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

func _on_state_shift(new_state) -> void:
	current_state.on_exit()
	current_state = new_state
	current_state.on_enter()
	
