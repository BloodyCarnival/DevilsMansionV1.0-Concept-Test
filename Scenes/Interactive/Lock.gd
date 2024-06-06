extends Node3D

@onready var cursor_mesh :MeshInstance3D = $CursorMesh
var digits :Array
var digits_rotation :Array
var digits_sides :int = 10
var can_interact : bool = LevelManager.can_interact_with_lock
var tweens :Array

var combination_final :Array
var combination_actual :Array

var cursor_pos_actual :int = 0

func _ready():
	#agrego los nodes a un array y tmb los tweens
	for digit in $Digits.get_children():
		digits.append(digit)
		digits_rotation.append(0)
		combination_actual.append(0)
		tweens.append(null)
	
	#Designar la combinacion final manual o random
	set_combination([1, 9, 7, 5])
	#set_combination([randi_range(0, 9), randi_range(0, 9), randi_range(0, 9), randi_range(0, 9)])
	
	#se puede asignar una combinacion manual o random
	sort_digits([0, 0, 0, 0])
	#sort_digits([randi_range(0, 9), randi_range(0, 9), randi_range(0, 9), randi_range(0, 9)])

func _input(event):
	if can_interact:
		#posicion del controlador del cursor
		if Input.is_action_just_pressed("ui_inventory_left"):
			cursor_pos_actual -= 1
			print(can_interact)
		if Input.is_action_just_pressed("ui_inventory_right"):
			cursor_pos_actual += 1
		cursor_pos_actual = clamp(cursor_pos_actual, 0, digits.size()-1)
		
		#mover digitos
		if Input.is_action_just_pressed("ui_inventory_up"):
			combination_actual[cursor_pos_actual] += 1
			digits_rotation[cursor_pos_actual] += deg_to_rad(360/digits_sides)
			move_digit()
		if Input.is_action_just_pressed("ui_inventory_down"):
			combination_actual[cursor_pos_actual] -= 1
			digits_rotation[cursor_pos_actual] -= deg_to_rad(360/digits_sides)
			move_digit()

func _physics_process(delta):
	#posicion del curson con lerp a la posicion de cada digito
	cursor_mesh.global_position.x = lerp(cursor_mesh.global_position.x, digits[cursor_pos_actual].global_position.x, delta * 12)
	if can_interact:
	#chech combination con enter o espacio
		if Input.is_action_just_pressed("ui_inventory_accept"):
			if combination_final == combination_actual:
				LevelManager.changeScene(LevelManager.VICTORY_SCENE, "res://Scenes/Levels/Entrance.tscn")
				LevelManager.lock_viewport_node.visible = false
			else:
				print("NOP")
		if Input.is_action_just_pressed("ui_inventory_close"):
			LevelManager.lock_viewport_node.visible = false
			can_interact = false

func move_digit():
	if combination_actual[cursor_pos_actual] < 0:
		combination_actual[cursor_pos_actual] = 9
	if combination_actual[cursor_pos_actual] > 9:
		combination_actual[cursor_pos_actual] = 0
	if tweens[cursor_pos_actual]:
		tweens[cursor_pos_actual].kill()
	tweens[cursor_pos_actual] = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tweens[cursor_pos_actual].tween_property(digits[cursor_pos_actual], "rotation:x", digits_rotation[cursor_pos_actual], 0.5)
	#print(combination_actual[cursor_pos_actual])

func sort_digits(combination:Array):
	#print(combination)
	for comb in combination.size():
		combination_actual[comb] = combination[comb]
		digits_rotation[comb] = deg_to_rad(360/digits_sides) * combination[comb]
		digits[comb].rotation.x = digits_rotation[comb]

func set_combination(combination:Array):
	combination_final = combination
	for t in combination_final:
		$Combination.text = $Combination.text + str(t)
