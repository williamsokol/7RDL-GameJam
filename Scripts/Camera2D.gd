extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var playerPath:NodePath
var player

#var started = false
# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().root, "ready")
	player = get_node(playerPath)
	var mapSize = get_node("/root/LevelManager").mapSize
	limit_left	=0
	limit_right	=mapSize.x*6
	limit_bottom=mapSize.y*6
	limit_top	=0
	pass # Replace with function body.
#	started = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if !started:
#		return
		
	position = player.position
