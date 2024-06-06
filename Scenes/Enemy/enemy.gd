extends CharacterBody3D

@onready var state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var navigation_agent_3d = $NavigationAgent3D
@onready var interaction_area = $InteractionArea
@onready var animations = $"Root Scene/AnimationPlayer"
@onready var enemy_state_machine = $EnemyStateMachine

var player_ref = Global.player_node
var SPEED = 1.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

