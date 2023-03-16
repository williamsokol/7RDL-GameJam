extends AnimatedSprite


export var enemyPath:NodePath
onready var enemy :KinematicBody2D= get_node(enemyPath)
var offsetFromParent:Vector2
onready var canvasLayer :CanvasLayer= get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	offsetFromParent = enemy.global_position - global_position
	canvasLayer.layer = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = enemy.global_position - offsetFromParent
	if(enemy._player):
		flip_h =  (enemy.position.x-enemy._player.position.x)>0


func _on_AnimatedSprite_animation_finished():
	animation = "Walk"
