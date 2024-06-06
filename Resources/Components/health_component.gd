extends Node
class_name HealthState
@export var MAX_HEALTH : float
var health : float
@onready var hurt_sound = $"../../PlayerHurt"


func _ready():
	health = MAX_HEALTH
	
func damage(attack : Attack):
	health -= attack.attack_damage
	if hurt_sound != null:
		hurt_sound.play()
		print("Quepasa")
func heal(heal_amount : int):
	health += heal_amount
	if health > MAX_HEALTH:
		health = MAX_HEALTH
