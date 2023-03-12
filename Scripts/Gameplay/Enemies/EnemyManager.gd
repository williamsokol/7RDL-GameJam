extends Node2D

export var playerPath:NodePath
onready var player = get_node(playerPath)
export var enemy:PackedScene
onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	timer.connect("timeout",self,"_on_Timer_timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Timer_timeout():
	var instance = enemy.instance()
	instance._player = player
	var rand = Vector2(randi()%100-50,randi()%100-50)
	add_child(instance)
	instance.position = player.position + rand.normalized()*100
