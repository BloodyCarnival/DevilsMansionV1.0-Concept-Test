extends SubViewportContainer

@onready var lock_scene = $SubViewport/LockScene

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.set_viewport_node(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
