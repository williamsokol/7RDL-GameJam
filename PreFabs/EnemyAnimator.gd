extends AnimatedSprite


export var enemyPath:NodePath
onready var enemy := get_node(enemyPath)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	flip_h =  (enemy.position.x-enemy._player.position.x)>0
