extends CharacterBody2D

@onready var page_adder: Control = $CanvasLayer/UI/PageAdder
@onready var left_page: Control = $CanvasLayer/UI/LeftPage
@onready var storage: Label = $CanvasLayer/UI/LeftPage/storage
@onready var upper_page: Control = $"CanvasLayer/UI/Upper Page"
@onready var right_page: Control = $CanvasLayer/UI/RightPage
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var center_bottom: Control = $CanvasLayer/UI/CenterBottom

@export var kumpulan_soal : Array[Resource]

const PANEL_UJIAN = preload("res://Scene/panel_ujian.tscn")

var all_page = []
var is_mancing = false

func _ready() -> void:
	all_page.append_array([left_page,upper_page,right_page])
	ScreenManager._play_music(preload("uid://bfemnhc0xecjh"))
	

func _kail() -> void:
	is_mancing = true
	kumpulan_soal.shuffle()
	var inst = PANEL_UJIAN.instantiate()
	inst.soal_res = kumpulan_soal.pick_random()
	add_page(inst)

func add_page(page_instance):
	page_adder.show()
	page_adder.add_child(page_instance)
	show_ui(false)

func show_ui(cond : bool):
	for i in all_page:
		i.visible = cond

func close_page():
	page_adder.hide()
	if page_adder.get_child_count() != 0 :
		for i in page_adder.get_children():
			i.queue_free()
	show_ui(true)
	is_mancing = false
	_update_storage()

func _jawaban_benar(res):
	var ikan = res
	if !Global.fish_storage.has(ikan.nama_ikan) :
		Global.fish_storage.merge({ikan.nama_ikan : 1})
		var inst = preload("res://Scene/panel_ikan_baru.tscn").instantiate()
		inst.ikan_res = res
		add_page(inst)
	else :
		Global.fish_storage[ikan.nama_ikan] += 1
		close_page()
	var notif = preload("res://Scene/notif_ikan.tscn").instantiate()
	notif._set_notif(res.image_ikan, res.nama_ikan)
	center_bottom.add_child(notif)
	upper_page.show()
	anim.play("Happy")

func _jawaban_salah():
	close_page()
	anim.play("Angry")

func _update_storage():
	storage.text = ""
	for i in Global.fish_storage:
		storage.text += i + " : " + str(Global.fish_storage[i]) + "\n"

func _on_kail_button_up() -> void:
	anim.play("Kail")
	_kail()

func _set_to_idle():
	anim.play("Idle")
	
func _on_pilih_bait_button_up() -> void:
	pass # Replace with function body.

func _on_main_menu_button_up() -> void:
	ScreenManager._change_scene("res://Scene/menu_page.tscn")

func _on_ensiklopedia_button_up() -> void:
	ScreenManager._change_scene("res://Scene/Ensiklopedia.tscn")

func _on_inventori_button_up() -> void:
	var inst = preload("uid://bvklw12eevkwi").instantiate()
	inst.parent = self
	add_page(inst)
