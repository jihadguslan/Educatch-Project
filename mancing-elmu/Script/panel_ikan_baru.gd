extends Control


@onready var fish_name: Label = $bg/panel/fish_name
@onready var icon_fish: TextureRect = $bg/panel/icon_fish

var ikan_res : Resource
var parent : Node

func _ready() -> void:
	parent = find_parent("Player")
	icon_fish.texture = ikan_res.image_ikan
	fish_name.text = ikan_res.nama_ikan

func _on_button_button_up() -> void:
	parent.close_page()
