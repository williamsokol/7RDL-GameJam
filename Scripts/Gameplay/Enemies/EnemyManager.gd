extends Node2D

#settings
export var enemyLimit:int

# references
export var playerPath:NodePath
onready var player = get_node(playerPath)
export var enemy:PackedScene
onready var timer = $Timer

var enemyList = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	timer.connect("timeout",self,"_on_Timer_timeout")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func StopEnemies():
	timer.paused = true
	print("enemies stopped")
	for e in enemyList:
		e.speed = 0
	
	var deathAnimTick = 4/enemyList.size()
	while (enemyList.size() > 0):
		yield(get_tree().create_timer(deathAnimTick), "timeout")
		
		var temp = enemyList[0]
		enemyList.remove(0)
		temp.die()
		
	

func _on_Timer_timeout():
	if(enemyList.size()< enemyLimit):
		var rand = Vector2(randi()%100-50,randi()%100-50)
		var enemyPos = player.position + rand.normalized()*100
		SpawnEnemy(enemyPos)
		
	for enemy in enemyList:
		if(enemy.position.distance_to(player.position)>200):
			var rand = Vector2(randi()%100-50,randi()%100-50)
			enemy.position = player.position + rand.normalized()*100
	
func SpawnEnemy(pos:Vector2 = Vector2.ZERO):
	var instance = enemy.instance()
	instance._player = player
	add_child(instance)
	
	enemyList.append(instance)
	instance.enemyManager = self
	instance.position = pos
