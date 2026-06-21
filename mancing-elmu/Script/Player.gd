extends CharacterBody2D

@onready var page_adder: Control = $CanvasLayer/UI/PageAdder
@onready var left_page: Control = $CanvasLayer/UI/LeftPage
@onready var upper_page: Control = $"CanvasLayer/UI/Upper Page"
@onready var right_page: Control = $CanvasLayer/UI/RightPage
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var center_bottom: Control = $CanvasLayer/UI/CenterBottom
@onready var pilih_bait: Button = $CanvasLayer/UI/LeftPage/PilihBait

@export var kumpulan_soal : Array[Resource]

const PANEL_UJIAN = preload("res://Scene/panel_ujian.tscn")
const click_sound = preload("uid://bpdxwfq1aukv")
const hover_sound = preload("uid://bksvvfkrx6ltg")


var all_page = []
var is_mancing = false

func _ready() -> void:
	all_page.append_array([left_page,upper_page,right_page])
	ScreenManager._play_music(preload("uid://bfemnhc0xecjh"))
	if !Global.used_bait: Global.used_bait = preload("uid://iaph6x01fech")
	pilih_bait.icon = Global.used_bait.bait_image

func _kail() -> void:
	if Global.bait_left[Global.used_bait.kode_soal] <= 0:
		_create_notif(Global.used_bait.bait_image, "Bait " + Global.used_bait.bait_name + " Habis! Isi ulang di menu bait!")
		ScreenManager._play_audio(preload("uid://urj4ukth26ut"), self)
		return
	Global.bait_left[Global.used_bait.kode_soal] -= 1
	if !kumpulan_soal.is_empty():
		kumpulan_soal.clear()
	is_mancing = true
	for i in DatabaseManager._bank_soal:
		if i.begins_with(SoalResource.DifficultString[Global.current_difficulty]) and i.ends_with(Global.used_bait.kode_soal) :
			kumpulan_soal.append_array(DatabaseManager._bank_soal[i].duplicate())
	kumpulan_soal.shuffle()
	var inst = PANEL_UJIAN.instantiate()
	inst.soal_res = kumpulan_soal.pick_random()
	add_page(inst)
	ScreenManager._play_audio(preload("uid://bays4yislwgmw"), self)

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
	pilih_bait.icon = Global.used_bait.bait_image
	ScreenManager._save_data()

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
	_create_notif(res.image_ikan, "+ " + res.nama_ikan)
	upper_page.show()
	anim.play("Happy")

func _create_notif(notif_image, notif_text):
	var notif = preload("res://Scene/notif_ikan.tscn").instantiate()
	notif._set_notif(notif_image, notif_text)
	center_bottom.add_child(notif)

func _jawaban_salah():
	close_page()
	anim.play("Angry")

func _on_kail_button_up() -> void:
	anim.play("Kail")
	_kail()

func _set_to_idle():
	anim.play("Idle")
	
func _on_pilih_bait_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	var inst = preload("res://Scene/bait_select.tscn").instantiate()
	inst.parent = self
	add_page(inst)

func _on_main_menu_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._change_scene("res://Scene/menu_page.tscn")

func _on_ensiklopedia_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	ScreenManager._change_scene("res://Scene/Ensiklopedia.tscn")

func _on_inventori_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	var inst = preload("uid://bvklw12eevkwi").instantiate()
	inst.parent = self
	add_page(inst)
