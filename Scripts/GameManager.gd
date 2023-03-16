# this is the high level node that handle anything persistent through all levels
# for instance music, level loading, score, 
extends Node

# references

# Globals
var currentOpenScene:Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	var root = get_tree().root
	currentOpenScene = root.get_child(root.get_child_count() - 1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func ResetLevel():
	yield(get_tree().create_timer(2.0), "timeout")
	LoadScene(currentOpenScene)
	pass
func LoadScene(scene):	

	if(currentOpenScene != null):
		currentOpenScene.queue_free()
	
	var instance = scene.instance()
	add_child(instance)
	
	currentOpenScene = instance
	
func TransitionScene(scene):
	var animPlayer = SceneTransistion.get_node("AnimationPlayer")
	animPlayer.play("dissolve")

	MusicManager.FadeIn(0)
	yield(animPlayer,"animation_finished")
	MenuManager.HideMenus()
	LoadScene(scene)
	MusicManager.UpdateTrack()
	
	animPlayer.play_backwards("dissolve")
	
