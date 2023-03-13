extends Control



var gameManager:Node

export var gameScene:PackedScene

func _ready():
	gameManager = get_node("/root/GameManager")
	if gameManager == null:
		printerr("could not find the gamemanger Scene in game, ur prob loaded scene in without it")
	else:
		print(gameManager)



func _on_Play_Button_button_down():
	gameManager.TransitionScene(gameScene)

	
