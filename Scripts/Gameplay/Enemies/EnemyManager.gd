extends Node2D

export var playerPath:NodePath
onready var player = get_node(playerPath)
export var enemy:PackedScene
onready var timer = $Timer

var enemyList:Array
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
	
	var deathAnimTick = .4
	while (enemyList.size() > 0):
		yield(get_tree().create_timer(deathAnimTick), "timeout")
		
		var temp = enemyList[0]
		enemyList.remove(0)
		temp.die()
		
	

func _on_Timer_timeout():
	
	var instance = enemy.instance()
	instance._player = player
	add_child(instance)
	enemyList.append(instance)
	instance.enemyManager = self
	
	var rand = Vector2(randi()%100-50,randi()%100-50)
	instance.position = player.position + rand.normalized()*100
	
