# this is the high level node that handle anything persistent through all levels
# for instance music, level loading, score, 
extends Node

var currentOpenScene:Node
export var startScene:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	LoadScene(startScene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func ResetLevel():
	yield(get_tree().create_timer(2.0), "timeout")
	print("test")
	LoadScene(startScene)
	pass
func LoadScene(scene):
	if(currentOpenScene != null):
		currentOpenScene.queue_free()
	
	var instance = scene.instance()
	add_child(instance)
	
	currentOpenScene = instance
		
