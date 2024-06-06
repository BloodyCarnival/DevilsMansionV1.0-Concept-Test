extends State
class_name EnemyAttackState

@onready var attack_collision = $"../../AttackCollision"

@export var chase_state : State
@export var death_state : State

var can_attack : bool = true
var attack_damage = 40

func state_process(delta):
	if health_state.health <= 0:
		next_state = death_state
	if attack_collision.get_overlapping_bodies().has(Global.player_node) and can_attack:
		can_attack = false
		character.animations.play("Tpose|Attack")


func _on_animation_player_animation_finished(attack_animation : String = "Tpose|Attack"):
	next_state = chase_state
	can_attack = true

func _on_damage_frame():
	if attack_collision.get_overlapping_bodies().has(Global.player_node):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		Global.player_node.health_component.damage(attack)
