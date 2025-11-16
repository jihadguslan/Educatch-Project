extends Control

@onready var label: Label = $Label
@onready var texture_rect: TextureRect = $Label/TextureRect

var texture_image
var notif_text = ""

func _ready() -> void:
	_prepare_notif()
	await get_tree().create_timer(1.0).timeout
	Global._make_tween(self, "position:y", -30.0, 1.5)
	Global._make_tween(self, "modulate:a", 0.0, 1.5)
	await get_tree().create_timer(1.5).timeout
	queue_free()

func _prepare_notif():
	texture_rect.texture = texture_image
	label.text = notif_text

func _set_notif(texture : Texture2D, text : String = "Label tidak diupdate!"):
	texture_image = texture
	notif_text = text
