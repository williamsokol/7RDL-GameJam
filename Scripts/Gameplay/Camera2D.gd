extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var playerPath:NodePath
export var levelManagerPath:NodePath
var player

#var started = false
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(playerPath)

	var levelManager = get_node(levelManagerPath)
	yield(levelManager, "ready")
	var mapSize = levelManager.mapSize
	

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
	if player:
		position = player.position
