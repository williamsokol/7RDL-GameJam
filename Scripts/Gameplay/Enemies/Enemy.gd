extends KinematicBody2D


export var speed:float
export var maxHp:float
export var attackDelay:float
onready var _hp := maxHp 

export var pathToPlayer:NodePath
onready var _player :Node2D
onready var attackTimer = get_node("AttackTimer")
onready var _agent : NavigationAgent2D= get_node("NavigationAgent2D")


var _velocity := Vector2.ZERO
var enemyManager:Node

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if(_player == null):
		_player = get_node(pathToPlayer)
#		printerr("Enemy needs a player in this scene!")
	_agent.set_target_location(_player.global_position)
	$NavTimer.connect("timeout",self,"_update_pathfinding")
	pass # Replace with function body.	f
	
func _physics_process(delta):
	navMovement(delta)
func navMovement(delta):
	if _agent.is_navigation_finished():
		if attackTimer.time_left == 0:
			attack()
		return
	var direction = global_position.direction_to(_agent.get_next_location())
#	print(_agent.get_next_location())
	
	var desiredVelocity = direction * speed
	var steering = (desiredVelocity-_velocity)* delta * 4
	_velocity += steering
	_velocity = move_and_slide(_velocity)	
func _update_pathfinding():
	_agent.set_target_location(_player.global_position)
	#print("player noticed")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func attack():
#	print("attacking player")
	attackTimer.wait_time = attackDelay
	_player.reciveDmg(1)

func _on_HitBox_Area2D_area_entered(area):
	if(area.is_in_group("Projectile")):
		#print("hurt")
		_hp = _hp - area.damage
		if(_hp <= 0):
			die()
		area.queue_free()
			
func die():
	if(enemyManager != null):
		enemyManager.enemyList.erase(self)
	queue_free()
