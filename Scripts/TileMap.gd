extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mapTileSize:Vector2
#var refTileMap = get_child(0)
var layers = []
var Grids = {} #make a diction for grids
#var rng = new Random.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	randomize()
	layers = get_children()
	mapTileSize = get_viewport_rect().size/ layers[0].cell_size
	CreateMap()
#func _process(delta):
#	if Input.is_action_just_pressed("Fire"):
#		CreateMap()
func CreateMap():
	# Create patchy Grass on map
	layers[0].clear()
	Grids["grass"] = RandomizedMap([-1,0])
	for i in range(2):
		Grids["grass"] = CellularAutomata(Grids["grass"],-1)

	# place Trees on Grass
	var treeGrids:Array
	treeGrids = placeTrees(Grids["grass"],[3])
	Grids["treeTrunk"] = treeGrids[0]
	Grids["treeLeafs"] = treeGrids[1]
	
	# Create some cabins 
	for i in range(2):
		var pos = Vector2(randi()% int(mapTileSize.x-10),randi()% int(mapTileSize.y-10))
		CreateCabin([Grids["grass"],create_2d_array(mapTileSize.y+1,mapTileSize.x+1,-1)], pos,Vector2(8,8))
	
	# load all the grids into the game
	LoadGrid(Grids["grass"],layers[0])
	LoadGrid(Grids["treeTrunk"],layers[2])
	LoadGrid(Grids["treeLeafs"],layers[3])
	layers[0].update_bitmask_region(Vector2.ZERO, mapTileSize)
	layers[2].update_bitmask_region(Vector2.ZERO, mapTileSize)

func RandomizedMap(tiles:Array):
	var result = create_2d_array(mapTileSize.y+1,mapTileSize.x+1,1)
	for x in mapTileSize.x:
		for y in mapTileSize.y:
			var cellType = tiles[randi()%tiles.size()]
			result[x][y] = cellType
	return result
#func LoadCell(x,y):
	
# this function is the core idea
func CellularAutomata(tileGrid,targetTile):
	var result = create_2d_array(mapTileSize.y+1,mapTileSize.x+1,1)
	var tempGrid = tileGrid.duplicate(true)
	
	for x in mapTileSize.x:
		for y in mapTileSize.y:
			var neighborCount = GetNeigborCount(tempGrid,x,y,targetTile)
			
			if(neighborCount > 4):
				result[x][y] = targetTile
			else:
				result[x][y] = 0
	return result
	
func isWithinBounds(x,y):
	if(x<0 or y<0 or x>= mapTileSize.x or y>=mapTileSize.y):
		return false
	return true

func clearSingleTiles(tileGrid,targetTile):
	var tempGrid = tileGrid.duplicate(true)
	
	for x in mapTileSize.x:
		for y in mapTileSize.y:
			#var neighborCount = GetNeigborCount(tempGrid,x,y,targetTile)
			if (tempGrid[x][y] == -1):
				continue
			if (layers[0].get_cell_autotile_coord(x,y)==Vector2.ZERO):
				tempGrid[x][y] = -1
	return tempGrid
	
func placeTrees(tileGrid:Array,tiles:Array):
	var trunkGrid = create_2d_array(mapTileSize.y+1,mapTileSize.x+1,-1)
	var leafGrid  = create_2d_array(mapTileSize.y+1,mapTileSize.x+1,-1)
	var result = [trunkGrid,leafGrid]
	for x in mapTileSize.x:
		for y in mapTileSize.y:
			if (tileGrid[x][y] == -1):
				continue
			if(randi()%20 != 0):
				continue
			#var cellType = tiles[randi()%tiles.size()]
			trunkGrid[x][y] = 3
			leafGrid[x][y-1] = 4
	return result
func CreateCabin(grids:Array,pos:Vector2,size:Vector2):
	#grids[0] =  create_2d_array(mapTileSize.y+1,mapTileSize.x+1,-1)
	#grids[1] =  create_2d_array(mapTileSize.y+1,mapTileSize.x+1,-1)
	var result = grids
	
	
	for i in size.x:
		for j in size.y:
			var x = i+pos.x
			var y = j+pos.y
			Grids["grass"][x][y] = 5
			Grids["treeTrunk"][x][y] = -1
			Grids["treeLeafs"][x][y-1] = -1
			
			if (randi()%10 == 0):
				continue
			if(i == 0 or i==size.x-1):
				Grids["treeTrunk"][x][y] = 6
			elif(j == 0 or j==size.y-1):
				Grids["treeTrunk"][x][y] = 6
	return result
func GetNeigborCount(tempGrid,x,y,targetTile):
	var neighborCount = 0
	for i in range(x-1,x+2):
		for j in range(y-1,y+2):
			if(!isWithinBounds(i,j)):
				continue
			if( x==i and y==j):
				continue
			if(tempGrid[i][j] == targetTile):
				neighborCount += 1
	return neighborCount

func LoadGrid(tileGrid,layer):
	for x in mapTileSize.x:
		for y in mapTileSize.y:
			layer.set_cell(x,y,tileGrid[x][y])

func create_2d_array(width, height, value):
	var a = []

	for y in range(height):
		a.append([])
		a[y].resize(width)

		for x in range(width):
			a[y][x] = value

	return a
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.

