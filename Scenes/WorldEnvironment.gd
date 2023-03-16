extends WorldEnvironment


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var levelManagerPath:NodePath
onready var levelManager = get_node(levelManagerPath)
var _timer = 0
var settingDuration
var tween:SceneTreeTween
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	tween = create_tween()
	var node_path = NodePath(".:environment:adjustment_brightness")
	# This will be parsed as a node path to the "x" component of the "position" property in the current node.
	var property_path = node_path.get_as_property_path()
	
	settingDuration = levelManager.countDownDuration
	tweenOverSec("environment:adjustment_brightness",.5,settingDuration/3)
	yield(get_tree().create_timer((settingDuration/6)*2),"timeout")
	tweenOverSec("environment:adjustment_contrast",5,30)
	yield(get_tree().create_timer((settingDuration/6)*3),"timeout")
	tweenOverSec("environment:adjustment_contrast",1,(settingDuration/7))
	tweenOverSec("environment:adjustment_brightness",1,settingDuration/6)
	yield(get_tree().create_timer(settingDuration/3),"timeout")
	
	#tween.tween_property(self,"environment.adjustment_brightness",.4,settingDuration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	_timer += delta
#
#	if(_timer> 1):
#		_timer = 0
#		var bright = range_lerp(count,start,end,intendedStart,intendedEnd)
#		print(get_property_list())
#		environment.adjustment_contrast = contrast
#		var lessTime = 20
#		var newCountDown = levelManager.countDown if levelManager.countDown> lessTime else lessTime
#		var contrast = range_lerp(count,20,settingDuration,4,1)
func tweenOverSec(property:NodePath, final_val,sec:int):
	var count = 0
	var initial_val = get_indexed(property)
	
	for i in range(sec):
		var newValue = range_lerp(count,0,sec,initial_val,final_val)
		self.set_indexed(property,newValue)
		count += 1
		yield(get_tree().create_timer(1),"timeout")

func wait(length):
	yield(get_tree().create_timer(length),"timeout")

