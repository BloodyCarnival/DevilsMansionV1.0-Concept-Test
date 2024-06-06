extends Sprite2D

@onready var model = $Container/SlotViewport/ModelScene/Model
@onready var quantity_label = $Quantity
var new_item : Item = null
var item_name : String
var item_effect : String
var item_type : String
var item_description : String
var item_quantity : int
var item_scene
var lerp : bool = true
var position_to = Vector2()
var scale_to = Vector2(1,1)

func set_empty():
	new_item = null
func set_item(new_item):
	item_name = new_item.name
	item_effect = new_item.effect
	item_type = new_item.type
	item_description = new_item.description
	item_quantity = new_item.quantity
	item_scene = new_item.scene
	render(item_scene)
	if item_quantity > 1:
		quantity_label.text = str(item_quantity)
	
func _physics_process(delta):
	if lerp:
		global_position = lerp(global_position, position_to, delta*9)
		scale = lerp(scale, scale_to, delta*9)
		model.rotate_y(delta*0.5)
func render(item_scene):
	if item_scene:
		var visible_mesh = item_scene.instantiate()
		model.add_child(visible_mesh)
func clear_model_child():
	while model.get_child_count() >0:
		var child = model.get_child(0)
		model.remove_child(child)
		child.queue_free()
