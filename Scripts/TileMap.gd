extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var grid:Array
var mapTileSize:Vector2
#var rng = new Random.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	randomize()
	mapTileSize = get_viewport_rect().size/ cell_size
	#grid = create_2d_array(mapTileSize.y+1,mapTileSize.x+1,1)
	
	#print(grid[64][37])
	
	
	clear()
	grid = ResetMap()
	#for i in range(2):
	#	grid = CellularAutomata(grid)
	LoadGrid(grid)
	
func ResetMap():
	var result = create_2d_array(mapTileSize.y+1,mapTileSize.x+1,1)
	for x in mapTileSize.x:
		for y in mapTileSize.y:
			var cellType = randi()%(1+1)
			result[x][y] = cellType
	return result
#func LoadCell(x,y):
	

func CellularAutomata(tileGrid):
	var result = create_2d_array(mapTileSize.y+1,mapTileSize.x+1,1)
	var tempGrid = tileGrid.duplicate(true)
	for x in mapTileSize.x:
		for y in mapTileSize.y:
			var neighborCount = 0
			for i in range(x-1,x+2):
				for j in range(y-1,y+2):
					if(!isWithinBounds(i,j)):
						continue
					if( x==i and y==j):
						continue
					if(tempGrid[i][j] == 1):
						neighborCount += 1
						#print(neighborCount)
			
			if(neighborCount > 4):
				#set_cell(x,y,1)
				result[x][y] = 1
			else:
				result[x][y] = 0
				#set_cell(x,y,0)
	return result
func isWithinBounds(x,y):
	if(x<0 or y<0 or x>= mapTileSize.x or y>=mapTileSize.y):
		return false
	return true
func LoadGrid(tileGrid):
	for x in mapTileSize.x:
		for y in mapTileSize.y:
			set_cell(x,y,tileGrid[x][y])

func create_2d_array(width, height, value):
	var a = []

	for y in range(height):
		a.append([])
		a[y].resize(width)

		for x in range(width):
			a[y][x] = value

	return a
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Fire"):
		grid = CellularAutomata(grid)
		LoadGrid(grid)
