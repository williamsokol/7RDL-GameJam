extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var levelManagerPath:NodePath
var levelManager
# Called when the node enters the scene tree for the first time.
func _ready():
	levelManager = get_node(levelManagerPath)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(levelManager)
	if(!levelManager):
		return
		
	text = levelManager.countDownTime
