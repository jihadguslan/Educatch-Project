extends CanvasLayer

@onready var version: Label = $"Menu Page/Corner Right/Version"
const click_sound = preload("uid://bpdxwfq1aukv")

func _ready() -> void:
	version.text = "Versi " + str(ProjectSettings.get_setting("application/config/version"))
	ScreenManager._play_music(preload("uid://duv4jajply6ne"))
	ScreenManager._load_data()

func _on_start_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._load_data()
	ScreenManager._change_scene("res://Scene/pilih_kategori.tscn")
	

func _on_exit_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._exit_game()


func _on_credit_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._change_scene("res://Scene/credit.tscn")
