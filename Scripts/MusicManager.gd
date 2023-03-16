extends AudioStreamPlayer


# settings
export var musicVolume:float 
export var sfxVolume:float
export var Tracks :Dictionary = {
	"res://Scenes/LevelRoom.tscn":"res://Music-Sounds/forest.mp3",
	"res://Scenes/Main.tscn":"res://Music-Sounds/demo_V2.mp3"
} 
var musicTween:SceneTreeTween

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.volume_db = musicVolume
	musicTween = create_tween()
	
#	musicTween =
func FadeIn(newSoundLevel):
	musicTween.tween_property(self, "volume_db", newSoundLevel, .5)
func UpdateTrack():
	if(Tracks.has(GameManager.currentOpenScene.filename) == false):
		return
	stream = load(Tracks[GameManager.currentOpenScene.filename])
	yield(get_tree().create_timer(.5),"timeout")
	print("new track playing")
	MusicManager.volume_db = musicVolume
	MusicManager.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
