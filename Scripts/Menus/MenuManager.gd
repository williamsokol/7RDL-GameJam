extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var levelRoomScene:PackedScene
export var mainMenuScene:PackedScene
export var CreditsScene:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func HideMenus():
	for menu in get_children():
		menu.visible = false
func ShowMenu(MenuName):
	var selectedMenu:Control = get_node(MenuName)
	print("ran this: " + str(selectedMenu.visible))
	selectedMenu.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TryAain_Button_button_down():
	pass # Replace with function body.
	GameManager.TransitionScene(levelRoomScene)
	get_node("MainMenu/AudioStreamPlayer").play()

func _on_Back_Button_to_menu_button_down():
	GameManager.TransitionScene(mainMenuScene)
	pass # Replace with function body.


func _on_Credits_Button_button_down():
	GameManager.TransitionScene(CreditsScene)
	pass # Replace with function body.


func _on_Music_Slider_value_changed(value):
	MusicManager.musicVolume = range_lerp(value, 0,100,-10,10)
	if MusicManager.musicVolume < -9:
		MusicManager.musicVolume = -80
	MusicManager.volume_db = MusicManager.musicVolume


func _on_Options_Back_button_down():
	$"Options Control".visible = false


func _on_Options_button_down():
	$"Options Control".visible = true
