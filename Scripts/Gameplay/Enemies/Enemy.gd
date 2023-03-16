extends KinematicBody2D


# settings
export var speed:float
export var maxHp:float
export var enemyDamage:float
export var attackDelay:float

# references
export var pathToPlayer:NodePath
onready var _player :Node2D
onready var spriteAnimator := $CanvasLayer/AnimatedSprite
onready var canvasLayer :CanvasLayer= $CanvasLayer
onready var attackTimer = get_node("AttackTimer")
onready var _agent : NavigationAgent2D= get_node("NavigationAgent2D")
var enemyManager:Node

# globals
onready var _hp := maxHp 
var direction = Vector2.ZERO
var _velocity := Vector2.ZERO
var attackingPlayer = false

# Called when the node enters the scene tree for the first time.
func _ready():
	while test_move(transform, Vector2(0,0)) == true:
		translate(Vector2(1,1))
	
	if(_player == null):
		_player = get_node(pathToPlayer)
#		printerr("Enemy needs a player in this scene!")
	else:
		_agent.set_target_location(_player.global_position)
		$NavTimer.connect("timeout",self,"_update_pathfinding")
	pass # Replace with function body.	f
	
func _physics_process(delta):
	if(_player):
		navMovement(delta)
func navMovement(delta):
#	print(_agent.get_next_location())

	var desiredVelocity = direction * speed
	var steering = (desiredVelocity-_velocity)* delta * 4
	_velocity += steering
	_velocity = move_and_slide(_velocity)	
func _update_pathfinding():
	direction = global_position.direction_to(_agent.get_next_location())
	_agent.set_target_location(_player.global_position)
	#print("player noticed")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func attack():
#	print("attacking player")
	while(attackingPlayer == true):
		spriteAnimator.animation = "Attack"
		$AudioStreamPlayer2D.play()
		#attackTimer.wait_time = attackDelay
		_player.reciveDmg(enemyDamage)
		yield(spriteAnimator,"animation_finished")
		

func _on_HitBox_Area2D_area_entered(area):
	if(area.is_in_group("Projectile")):
		#print("hurt")
		TakeDamage(area.damage)
		area.queue_free()
	
func TakeDamage(dmg):
	
	# visuals
	spriteAnimator.animation = "Hit"
	canvasLayer.layer = 2
	# mechanics
	var storedSpeed = speed
	speed = 0
	spriteAnimator.frame = 0
	_hp = _hp - dmg
	if(_hp <= 0):
			die()
			
	yield(spriteAnimator, "animation_finished")
	# reset enemy
	canvasLayer.layer = 0
	speed = storedSpeed
func die():
	if(enemyManager != null):
		enemyManager.enemyList.erase(self)
	queue_free()


func _on_HitBox_Area2D_body_entered(body):
	
	if(body.is_in_group("Player")):
		attackingPlayer = true
#		print("attacking player")
		attack()
		
func _on_HitBox_Area2D_body_exited(body):
	if(body.is_in_group("Player")):
		attackingPlayer=false
	pass # Replace with function body.
