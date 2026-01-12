extends CanvasLayer

const click_sound = preload("uid://bpdxwfq1aukv")

func _on_kembali_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._change_scene("res://Scene/menu_page.tscn")
