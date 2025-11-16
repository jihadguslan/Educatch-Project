extends Control

@onready var nama: Label = $Control/Panel/Panel/VBoxContainer/nama
@onready var sisa: Label = $Control/Panel/Panel/VBoxContainer/Sisa
@onready var deskripsi: Label = $Control/Panel/Panel/VBoxContainer/Deskripsi
@onready var coins: Label = $Control/Coins
@onready var image_tex: TextureRect = $Control/Panel/Panel/TextureRect

var bait_buttons = []
@export var bait_res : Array[Resource]
@onready var harga: Label = $Control/Panel/Panel/VBoxContainer/Harga

var data_get = {}
var parent

func _ready() -> void:
	Global._make_tween(self, "position:y", 0.0, 0.8)
	bait_buttons.append_array([$Control/Panel/VBoxContainer/Button, $Control/Panel/VBoxContainer/Button2, $Control/Panel/VBoxContainer/Button3, $Control/Panel/VBoxContainer/Button4])
	for i in range(bait_buttons.size()):
		bait_buttons[i].res = bait_res[i]
		bait_buttons[i].prepare()
		bait_buttons[i]._send_data.connect(_get_data_bait)
	nama.text = "Nama : " + Global.used_bait.bait_name
	sisa.text = "Sisa : " + str(Global.bait_left[Global.used_bait.kode_soal])
	deskripsi.text = "Deskripsi : " + Global.used_bait.deskripsi
	harga.text = "Harga : " + str(Global.used_bait.price)
	image_tex.texture = Global.used_bait.bait_image
	coins.text = "Coins : " + str(Global.coins)

func _get_data_bait(data):
	data_get = data
	nama.text = "Nama : " + data.Res.bait_name
	sisa.text = "Sisa : " + str(data.button_node.total)
	deskripsi.text = "Deskripsi : " + data.Res.deskripsi
	harga.text = "Harga : " + str(data.Res.price)
	image_tex.texture = data.Res.bait_image
	Global.used_bait = data.Res.duplicate()

func _on_back_button_up() -> void:
	Global._make_tween(self, "position:y", 800.0, 0.8)
	await get_tree().create_timer(0.8, false, true).timeout
	parent.close_page()

func _on_buy_button_up() -> void:
	if Global.coins >= data_get.Res.price:
		Global.coins -= data_get.Res.price
		Global.bait_left[Global.used_bait.kode_soal] += 1
		_update_preview()

func _on_buy_10_button_up() -> void:
	if Global.coins >= data_get.Res.price * 10:
		Global.coins -= data_get.Res.price * 10
		Global.bait_left[Global.used_bait.kode_soal] += 10
		_update_preview()

func _update_preview():
	if !data_get.is_empty():
		data_get.button_node.prepare()
		sisa.text = "Sisa : " + str(data_get.button_node.total)
	coins.text = "Coins : " + str(Global.coins)
