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

# if init isn't, that's null good dawg we'll just get the first child
func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)

# connect our state_aspires_to signals, use names as ref key in states
func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_aspires_to.connect(_on_state_shift)
			states[child.name] = child
	await owner.ready
	current_state.on_enter()
	
# status in motu est. we wait for the signal to change
func _on_state_shift(desired_state: String) -> void:
	shift_state_to(states.get(desired_state, initial_state))

# exit, remember, switch, enter
func shift_state_to(new_state: State) -> void:
	current_state.on_exit()
	history.append(current_state.name)
	current_state = new_state
	current_state.on_enter()

# at last we call these three. now we are only ever processing a single state
func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)
