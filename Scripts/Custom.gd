extends Reference


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
static func create_2d_array(width, height, value = null):
	var a = []

	for x in range(width):
		a.append([])
		a[x].resize(height)

		for y in range(height):
			a[x][y] = value

	return a

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
