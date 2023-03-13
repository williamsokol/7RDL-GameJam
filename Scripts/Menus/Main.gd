extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var startScene:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.LoadScene(startScene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
