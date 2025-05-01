class_name StateMachine
extends Node2D

signal state_changed

@onready var current_state: Node = get_child(0)
var previous_state : Node
var states : Dictionary

func change_state(new_state) -> void:
	
	if typeof(new_state) == TYPE_STRING_NAME || typeof(new_state) == TYPE_STRING:
		new_state = states[new_state]
	print("State change ", new_state.name)
	
	if current_state:
		current_state.exit()
	
	previous_state = current_state
	current_state  = new_state
	current_state.enter()
	emit_signal("state_changed", current_state)

#Initialize the state machine by giving each state a reference to the objects
# owned by the parent that they should be able to take control of
# and set a default state
func init(actor: Actor) -> void:
	await owner.ready
	for child in get_children():
		child.actor = actor
		states[child.name] = child
	print(states)
	change_state(current_state.name)
	

func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state != current_state:
		change_state(new_state)
		
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state != current_state:
		change_state(new_state)
