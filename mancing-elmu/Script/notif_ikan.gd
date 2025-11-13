extends Control

@onready var label: Label = $Label
@onready var texture_rect: TextureRect = $TextureRect

var texture_image
var nama_ikan = ""
func _ready() -> void:
	_prepare_notif()
	Global._make_tween(self, "position:y", -30.0, 0.8)
	Global._make_tween(self, "modulate:a", 0.0, 1.0)
	await get_tree().create_timer(1.0).timeout
	queue_free()

func _prepare_notif():
	texture_rect.texture = texture_image
	label.text = nama_ikan

func _set_notif(texture : Texture2D, ikan : String = "Label tidak diupdate!"):
	texture_image = texture
	nama_ikan = ikan
