extends Node2D

@onready var image_preview: Sprite2D = $UI/Screen/BoxLeft/ImageControl/Sprite2D
@onready var nama_ikan: Label = $UI/Screen/BoxLeft/BLeftDown/box_label/nama_ikan
@onready var rarity_ikan: Label = $UI/Screen/BoxLeft/BLeftDown/box_label/rarity_ikan
@onready var deskripsi_ikan: Label = $UI/Screen/BoxLeft/BLeftDown/box_label/deskripsi_ikan
@onready var box: FlowContainer = $UI/Screen/BoxRight/BoxAnchor/Scroller/Box
@onready var sprite_2d: Sprite2D = $UI/Screen/BoxLeft/ImageControl/Sprite2D
@onready var box_left: Control = $UI/Screen/BoxLeft
@onready var box_right: Control = $UI/Screen/BoxRight
@onready var screen: Control = $UI/Screen
@onready var button_show_hide: Button = $"UI/Screen/BoxRight/show hide"
@onready var all_fish: Control = $UI/Screen/AllFish

var rarity_names = ["Common", "Rare", "Epic", "Legendary", "God"]
const BUTTON_ENSIK = preload("res://Scene/button_ensik.tscn")

func _ready() -> void:
	box_right.position.x = box_right.position.x + box_right.get_rect().size.x
	box_left.position.y = box_left.position.y + box_left.get_rect().size.y
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
	var fish_res = _sort_by_rarity()
	for i in fish_res :
		var inst = BUTTON_ENSIK.instantiate()
		#inst.connect("_send_data", _get_data_ikan)
		inst._send_data.connect(_get_data_ikan)
		if Global.fish_storage.has(i.nama_ikan) :
			inst.unlock = true
			_spawn_ikan_randomly(i, Global.fish_storage[i.nama_ikan])
		inst.res = i.duplicate()
		box.add_child(inst)

func _sort_by_rarity():
	var common = []
	var rare = []
	var epic = []
	var legend = []
	var fish_res = DatabaseManager._get_semua_ikan().duplicate()
	for i in fish_res:
		if i.rarity == 0 :
			common.append(i)
		elif i.rarity == 1 :
			rare.append(i)
		elif i.rarity == 2 :
			epic.append(i)
		else :
			legend.append(i)
	return common + rare + epic + legend

const FISH_ALIVE = preload("uid://bdsfj0mattapm")

func _spawn_ikan_randomly(res, jumlah : int):
	for i in range(jumlah):
		var inst = FISH_ALIVE.instantiate()
		inst.texture = res.image_ikan
		var rand_pos = Vector2(randf_range(0, all_fish.get_rect().size.x), randf_range(0, all_fish.get_rect().size.y))
		inst.global_position = rand_pos
		all_fish.add_child(inst)
	
func _on_back_button_up() -> void:
	ScreenManager._play_audio(preload("uid://bpdxwfq1aukv"), self)
	ScreenManager._change_scene("res://Scene/Main World.tscn")

var boxRightShow = false
var on_tween = false
func _on_show_hide_button_down() -> void:
	boxRightShow = !boxRightShow
	on_tween = true
	var box_pos = box_right.position.x
	if boxRightShow :
		Global._make_tween(box_right, "position:x", box_pos - box_right.get_rect().size.x, 0.5)
		Global._make_tween(box_left, "position:y", box_left.position.y - box_left.get_rect().size.y, 0.5)
		button_show_hide.icon = preload("uid://dc073vrn7440w")
	else :
		Global._make_tween(box_right, "position:x", box_pos + box_right.get_rect().size.x, 0.5)
		Global._make_tween(box_left, "position:y", box_left.position.y + box_left.get_rect().size.y, 0.5)
		button_show_hide.icon = preload("uid://coqadt3sp4v5s")
	await get_tree().create_timer(0.5).timeout
	on_tween = false
