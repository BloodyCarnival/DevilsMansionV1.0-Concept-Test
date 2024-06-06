extends State
class_name Idle
@export var run_state : State
@export var walk_state : State
@export var aim_state : State
@export var death_state : State

func state_input(event: InputEvent):
	if event.is_action_pressed("running"):
		next_state = run_state
	if event.is_action_pressed("move_backwards") or event.is_action_pressed("move_forward"):
		next_state = walk_state
	if event.is_action_pressed("aim"):
		next_state = aim_state

func state_process(delta):
	character.animation_player.play("Prota|Idle")
	if character.velocity != Vector3.ZERO and not Input.is_action_just_pressed("running"):
		next_state = walk_state
	if health_state.health <= 0:
		next_state = death_state
