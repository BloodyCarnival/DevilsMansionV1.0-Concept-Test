extends State
class_name Death

func on_enter():
	character.animation_player.play("Prota|Death")

func on_change_to_game_over_screen():
	LevelManager.changeScene(LevelManager.GAME_OVER_SCENE, "res://Scenes/Levels/Entrance.tscn")
