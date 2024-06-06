extends CharacterBody3D

@onready var inventory_ui = %InventoryUI
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var inventory_interface = %InventoryInterface
@onready var health_component = $Components/HealthComponent
@onready var animation_player = $"Root Scene/AnimationPlayer"

const TURN_SPEED = 180
const GRAVITY = 98
const MAX_FALL_SPEED = 30

var MOVE_SPEED : float

func _ready():
	Global.set_player_reference(self)
	Global.player_health_component = health_component
func _physics_process(delta: float) -> void:
	var y_velo = 0
	var grounded = false

	var move_dir = (Input.get_action_strength("move_forward") - Input.get_action_strength("move_backwards"))
	var turn_dir = (Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right"))
	rotation_degrees.y += turn_dir * TURN_SPEED * delta
	if state_machine.check_if_can_move():
		var move_vec = global_transform.basis.z * MOVE_SPEED * move_dir
		move_vec = global_transform.basis.z * MOVE_SPEED * move_dir
		move_vec.y = y_velo

		velocity = move_vec
		move_and_slide()
	var was_grounded = grounded
	grounded = is_on_floor()
	y_velo -= GRAVITY * delta
	if grounded:
		y_velo -= 0.3
	if y_velo < -MAX_FALL_SPEED:
			y_velo = -MAX_FALL_SPEED

func _input(event):
	if Input.is_action_just_pressed("inventory"):
		inventory_interface.visible =!inventory_interface.visible
		#get_tree().paused = !get_tree().paused
		inventory_interface.update_health_icon()
func start_scene_position(start_position):
	position = start_position
