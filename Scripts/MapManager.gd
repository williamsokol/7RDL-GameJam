extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var layers = 6
export var location:PackedScene
export var linePacked:PackedScene

var locations:Array
var firstLoc
var lastLoc

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var Custom = load("res://Scripts/Custom.gd")
	var mapSize = get_viewport_rect().size
	
	
	
	locations = Custom.create_2d_array(layers,1)
	# generate nodes
	
	# first and last location
	firstLoc = location.instance()
	add_child(firstLoc)
	firstLoc.position = Vector2(mapSize.x/2,mapSize.y-100)
	lastLoc = location.instance()
	add_child(lastLoc)
	lastLoc.position = Vector2(mapSize.x/2,0+100)
	
	
	locations[0][0] = firstLoc
	locations[layers-1][0] = lastLoc
	# make the middle locations
	
	CreateLocations()
	CreateConnections()
func CreateLocations():
	for i in range(1,layers-1):
	
		var zones
		while (zones == locations[i-1].size() || zones == null):
			zones = 2 if i==1 else (randi()%3)+2

		locations[i].resize(zones) 
		for j in zones:
			var iteratDist = Vector2(100,((firstLoc.position.y-lastLoc.position.y)/(layers-1)))
			var startPos = firstLoc.position
			startPos.x = startPos.x - ((zones-1)*iteratDist.x)/2
			var pos = Vector2(
				startPos.x + (j)*iteratDist.x,
				startPos.y - ((i)*iteratDist.y) )
			
			var instance = location.instance()
			add_child(instance)
			instance.position = pos
			locations[i][j] = instance
func CreateConnections():
	for i in range(1,locations.size()):
		var layer = locations[i]
		var prevLayer = locations[i-1]
		var midLocs = getMidLocs(layer.size())
		var prevMidLocs = getMidLocs(prevLayer.size())
		for j in range(layer.size()):
			var curLoc = layer[j]
			var avgNum = (1+layer.size())/2
			
			#print(midLocs)
			if midLocs.has(j):
				#perform middle Location operation
				if midLocs.size() == 2:
					var a = layer[midLocs[0]]
					var b = prevLayer[prevMidLocs[0]]
					var c = layer[midLocs[1]]
					var d = prevLayer[prevMidLocs[prevMidLocs.size()-1]]
					if(prevLayer.size() ==3):
						var side = getSideLocs(prevLayer.size())
						DrawLine(a,prevLayer[side[0]])
						DrawLine(c,prevLayer[side[1]])
					DrawLine(a,b)
					DrawLine(c,d)
				elif midLocs.size() == 1:
					var a = layer[midLocs[0]]
					for b in prevMidLocs:
						DrawLine(a,prevLayer[b])
			if getSideLocs(layer.size()).has(j):
				#perform non middle location
				if(j == 0):
					var a = layer[0]
					var b = prevLayer[0]
					if(prevLayer.size()>layer.size()):
						var c = prevLayer[1]
						DrawLine(a,c)
					DrawLine(a,b)
				if(j == layer.size()-1):
					var a = layer[layer.size()-1]
					var b = prevLayer[prevLayer.size()-1]
					if(prevLayer.size()>layer.size()):
						var c = prevLayer[prevLayer.size()-2]
						DrawLine(a,c)
					DrawLine(a,b)
	
func getMidLocs(num:int):
	var midLocs:Array
	if num%2 == 0:
		var tmpLoc = num/2
		midLocs = [tmpLoc-1,tmpLoc]
	else:
		midLocs = [(1 + num/2)-1]
				
	return midLocs
func getSideLocs(num:int):
	var sideLocs:Array
	return [0,num-1]

	
func DrawConnections(location:Node2D):
	var line:Line2D
	line = linePacked.instance()
	add_child(line)
	for i in range(location.connections.size()):
#		print(location.connections[0])
		line.points[0] = (location.position)
		line.points[1] = location.connections[0].position
func DrawLine(obj1,obj2):
	var line:Line2D
	line = linePacked.instance()
	add_child(line)
	line.points[0] = (obj1.position)
	line.points[1] = obj2.position
	obj2.connections.append(obj1)
	#location.position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
