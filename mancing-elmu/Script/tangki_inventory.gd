extends Node2D

@onready var image_preview: Sprite2D = $UI/Screen/BoxLeft/ImageControl/Sprite2D
@onready var nama_ikan: Label = $UI/Screen/BoxLeft/BLeftDown/box_label/nama_ikan
@onready var rarity_ikan: Label = $UI/Screen/BoxLeft/BLeftDown/box_label/rarity_ikan
@onready var deskripsi_ikan: Label = $UI/Screen/BoxLeft/BLeftDown/box_label/deskripsi_ikan
@onready var box: FlowContainer = $UI/Screen/BoxRight/BoxAnchor/Scroller/Box
@onready var sprite_2d: Sprite2D = $UI/Screen/BoxLeft/ImageControl/Sprite2D
@onready var box_left: Control = $UI/Screen/BoxLeft

var rarity_names = ["Common", "Rare", "Epic", "Legendary", "God"]
const BUTTON_ENSIK = preload("res://Scene/button_ensik.tscn")

func _ready() -> void:
	box_left.hide()
	_set_ensiklopedia()
	
func _get_data_ikan(data : Dictionary, unlock : bool):
	box_left.show()
	print(box_left.visible)
	var res = data.resource.duplicate()
	image_preview.texture = res.image_ikan
	if unlock:
		image_preview.modulate = Color.WHITE
		nama_ikan.text = "Nama Ikan : "  + res.nama_ikan
		rarity_ikan.text = "Rarity : " + rarity_names[res.rarity]
		deskripsi_ikan.text = "Deskripsi : " + res.deskripsi_ikan
	else: 
		image_preview.modulate  = Color.BLACK
		nama_ikan.text = "Nama Ikan : ???"
		rarity_ikan.text = "Rarity : ???"
		deskripsi_ikan.text = "Deskripsi : ???"

func _set_ensiklopedia():
	var fish_res = DatabaseManager._get_semua_ikan().duplicate()
	for i in fish_res :
		var inst = BUTTON_ENSIK.instantiate()
		#inst.connect("_send_data", _get_data_ikan)
		inst._send_data.connect(_get_data_ikan)
		if Global.fish_storage.has(i.nama_ikan) :
			inst.unlock = true
		inst.res = i.duplicate()
		box.add_child(inst)

func _on_back_button_up() -> void:
	ScreenManager._change_scene("res://Scene/Main World.tscn")
