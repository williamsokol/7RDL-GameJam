extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var playerPath:NodePath
onready var player := get_node(playerPath)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	max_value = player.maxHp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = player._hp
