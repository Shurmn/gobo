class_name StateMachine
extends Node

# what can we be
var states := {}

# what have we been
var history := []

# how we began
@onready var initial_state: State  = _resolve_initial_state()
@export var default_state: State

# how we are now
@onready var current_state: State

# are we awake
var _awake := false

# connect our state_aspires_to signals, use names as ref key in states
func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_wants_to_change.connect(_change_state)
			states[child.name] = child
	awaken()

# if init isn't, that's null good dawg we'll just get the first child
func _resolve_initial_state() -> State:
	if not default_state:
		return find_child("*State")
	return default_state

# something something machine spirits
func awaken() -> void:
	_awake = true
	set_physics_process(true)
	set_process_input(true)
	
	# if we remember our last state, resume it
	if not history.is_empty(): 
		current_state = history.back()
		return
		
	# otherwise, initialize
	current_state = initial_state
	current_state.on_enter()

# relieve the weary laborer. not sure this works really
func sleep() -> void:
	_awake = false
	current_state.on_exit()
	current_state = null
	set_physics_process(false)
	set_process_input(false)

# status in motu est. we wait for the signal to change
func _change_state(desired_state: String) -> void:
	change_state_to(states.get(desired_state, initial_state))

# exit, remember, switch, enter
func change_state_to(new_state: State) -> void:
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
