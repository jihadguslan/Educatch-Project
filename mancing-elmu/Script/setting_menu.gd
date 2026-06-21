extends Control

@onready var music_slider: HSlider = $Panel/VBoxContainer/music_slider
@onready var sfx_slider: HSlider = $Panel/VBoxContainer/sfx_slider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_music_slider_value_changed(value: float) -> void:
	Global.music_volume = value
	AudioServer.set_bus_volume_db(2, value)

func _on_sfx_slider_value_changed(value: float) -> void:
	Global.sfx_volume = value
	AudioServer.set_bus_volume_db(1, value)
	
