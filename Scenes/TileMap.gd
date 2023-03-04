extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mapTileSize:Vector2
#var rng = new Random.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	mapTileSize = get_viewport_rect().size/ cell_size
	#mapTileHeight = get_viewport_rect().size.y/ cell_size.y
	clear()
	for i in mapTileSize.x:
		for j in mapTileSize.y:
			LoadCell(i,j)
func LoadCell(x,y):
	var cellType = randi()%(1+1)
	set_cell(x,y,cellType)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
