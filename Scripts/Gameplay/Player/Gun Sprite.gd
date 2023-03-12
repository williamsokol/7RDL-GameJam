extends Sprite

export var distFromPlayer:float
export var playerPath:NodePath
onready var player = get_node(playerPath)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	Vector2.ZERO.normalized()
	position = player._mouseDirection.normalized() * distFromPlayer
	rotation_degrees = player._mouseAngle-90
	
	flip_v = position.x<0
	

