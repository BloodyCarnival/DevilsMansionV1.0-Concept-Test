extends Label

@export var state_machine: CharacterStateMachine
@export var character : CharacterBody3D
func _process(_delta):
	text = "State : " + state_machine.current_state.name
