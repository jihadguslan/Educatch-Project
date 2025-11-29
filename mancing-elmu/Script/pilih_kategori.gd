extends CanvasLayer

const click_sound = preload("uid://bpdxwfq1aukv")

func _on_sd_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._change_scene("res://Scene/Main World.tscn")

func _on_smp_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	#ScreenManager._change_scene("res://Scene/Main World.tscn")

func _on_sma_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	#ScreenManager._change_scene("res://Scene/Main World.tscn")


func _on_kembali_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._change_scene("res://Scene/menu_page.tscn")

func _on_inventory_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	pass # Replace with function body.

func _on_ensiclopedia_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._change_scene("res://Scene/Ensiklopedia.tscn")
