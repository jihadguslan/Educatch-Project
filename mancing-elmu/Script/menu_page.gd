extends CanvasLayer

@onready var version: Label = $"Menu Page/Corner Right/Version"
const click_sound = preload("uid://bet4wwsgtcqj6")

func _ready() -> void:
	version.text = ProjectSettings.get_setting("application/config/version")
	ScreenManager._stop_music()

func _on_start_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._change_scene("res://Scene/pilih_kategori.tscn")
	
func _on_setting_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)

func _on_exit_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._exit_game()
