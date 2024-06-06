extends Node
class_name EnemyStateMachine
@export var initial_state : State
@export var current_state : State
@export var character : CharacterBody3D
var states : Array = []
func _ready():
	for child in get_children():
		if (child is State):
			states.append(child)
			child.character = character
		else:
			push_warning("Warning this is not a State")
func _physics_process(delta):
	if current_state.next_state != null:
		switch_states(current_state.next_state)
	
	current_state.state_process(delta)
func check_if_can_move():
	return current_state.can_move
func switch_states(new_state : State):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	current_state.on_enter()
