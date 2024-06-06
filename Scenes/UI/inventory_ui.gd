extends Control

var actual_position = 0
var selected_item : int = 0
var item_positions : Array = []
var equiped_item_position
var equiped_item
var equiped_item_render
var can_use : bool = false
#@onready var item_command_use = get_node("BottomText/ItemCommandOption")
@onready var items = %Item
@onready var health_status = $Healthstatus
@onready var name_item = %Name_item
@onready var description = %Description
@onready var equiped_slot = $EquipedSlot
@onready var item_command_use = $"Top Text/Textures/CommandTexture/EquipedCommand"
@onready var move_sound = $MoveSound
@onready var equip_sound = $EquipSound
@onready var heal_sound = $HealSound

var model_path : String = "InventoryUI/InventoryInterface/EquipedSlot/Container/SlotViewport/ModelScene/Model"

func _process(delta):
	if self.visible == true:
		can_use = true
	elif self.visible == false:
		can_use = false

func _ready():
	Global.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()
	item_positions = [
			$Positions/Center.global_position,
			$Positions/Right0.global_position,
			$Positions/Right1.global_position,
			$Positions/Right2.global_position,
			$Positions/Left0.global_position,
			$Positions/Left1.global_position,
			$Positions/Left2.global_position
			]
	equiped_item_position = $Equiped_item_position.global_position
func _on_inventory_updated():
	clear_item_child()
	for item in Global.inventory:
		var slot = Global.inventory_slot_scene.instantiate()
		if item:
			items.add_child(slot)
			slot.set_item(item)
			move(0)
		else:
			slot.set_empty()

func clear_item_child():
	while items.get_child_count() >0:
		var child = items.get_child(0)
		items.remove_child(child)
		child.queue_free()

func _input(event):
	if can_use == true:
		if Input.is_action_just_pressed("ui_inventory_left"):
			move(-1)
		if Input.is_action_just_pressed("ui_inventory_right"):
			move(1)
		if Input.is_action_just_pressed("ui_inventory_accept"):
			current_item()
		if Input.is_action_just_pressed("inventory"):
			can_use = false
func current_item():
	for item in items.get_children():
		if item.get_index() == actual_position and item.item_type == "Book":
			equip_sound.play()
			equiped_item = item
			equiped_slot.clear_model_child()
			equiped_slot.render(item.item_scene)
			equiped_slot.position_to = equiped_item_position
		if item.get_index() == actual_position and item.item_type == "Healing":
			Global.player_node.health_component.heal(60)
			update_health_icon()
			heal_sound.play()
			if item.item_name == "Botiquín Médico":
				Global.remove_item(item)
				item.item_quantity -= 1
				if item.item_quantity <= 0:
					item.queue_free()
					move(0)
func move(direction):
	move_sound.play()
	actual_position += direction
	if actual_position < 0:
		actual_position = items.get_child_count() - 1
	if actual_position >  items.get_child_count() - 1:
		actual_position = 0
	for item in items.get_children():
		if item.get_index() == actual_position:
			item.position_to = item_positions[0]
		elif item.get_index() == actual_position+1:
			item.position_to = item_positions[1]
		elif item.get_index() == actual_position+2:
			item.position_to = item_positions[2]
		elif item.get_index() > actual_position+2:
			item.position_to = item_positions[3]
		elif item.get_index() == actual_position-1:
			item.position_to = item_positions[4]
		elif item.get_index() == actual_position-2:
			item.position_to = item_positions[5]
		elif item.get_index() < actual_position-2:
			item.position_to = item_positions[6]
	item_text()
	item_command()
func update_health_icon():
	var health = Global.player_health_component.health
	if health:
		if health <= 100 and health >= 67:
			health_status.texture = health_status.fine_status
		elif health <= 66 and health >= 34:
			health_status.texture = health_status.caution_status
		elif health <= 33:
			health_status.texture = health_status.danger_status	
func item_text():
	for item in items.get_children():
		if item.get_index() == actual_position:
			name_item.text = item.item_name
			description.text = item.item_description
func item_command():
	for item in items.get_children():
		if item.get_index() == actual_position:
			if item.item_name == "Botiquín Médico":
				item_command_use.text = str("Usar")
			elif item.item_type == "Book":
				item_command_use.text = "Equipar"
func set_equiped_slot():
	for i in equiped_slot.get_children():
		i.position_to = equiped_item_position
