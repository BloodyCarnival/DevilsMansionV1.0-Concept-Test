extends Node
class_name State

@export var can_move : bool = true
@export var health_state : HealthState
var character : CharacterBody3D
var next_state : State


signal Transitioned

func on_enter():
	pass
func on_exit():
	pass
func state_input(event : InputEvent):
	pass
func state_process(delta):
	pass
