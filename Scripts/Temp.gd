extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var tileMapsPath:NodePath
var tileMaps
# Called when the node enters the scene tree for the first time.
func _ready():
	tileMaps = get_node("../TileMaps")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Fire"):
		tileMaps.CreateMap()
