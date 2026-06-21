extends Control

@onready var soal: Label = $Panel/Soal
@onready var button_group = [$Panel/VBoxContainer/Pilgan1/A, $Panel/VBoxContainer/Pilgan2/B, $Panel/VBoxContainer/Pilgan1/C, $Panel/VBoxContainer/Pilgan2/D]
@onready var status: Label = $Panel/status
@onready var box: VBoxContainer = $Panel/VBoxContainer

var soal_res : Resource
var parent
@onready var c: Button = $Panel/VBoxContainer/Pilgan1/C

func _ready() -> void:
	
	box.show()
	parent = find_parent("Player")
	soal.text = soal_res.isi_soal
	soal.label_settings["font_size"] = int(soal.label_settings["font_size"] - (soal_res.isi_soal.length() * 0.02))
	for i in range(button_group.size()):
		button_group[i].text = soal_res.pilihan_soal[i]
		var default_size = button_group[i]["theme_override_font_sizes/font_size"]
		button_group[i]["theme_override_font_sizes/font_size"] = int(default_size - (soal_res.pilihan_soal[i].length() * 0.06))
	Global._make_tween(self, "position:y", 0.0, 1.2)
	await get_tree().create_timer(0.8).timeout
	ScreenManager._play_audio(preload("uid://clc5l7fftv6sc"), parent)

func _on_a_button_up() -> void:
	_end_action(soal_res.jawaban_soal == 0)

func _on_b_button_up() -> void:
	_end_action(soal_res.jawaban_soal == 1)

func _on_c_button_up() -> void:
	_end_action(soal_res.jawaban_soal == 2)

func _on_d_button_up() -> void:
	_end_action(soal_res.jawaban_soal == 3)

func _end_action(benar : bool):
	box.hide()
	status.show()
	if benar: 
		ScreenManager._play_audio(preload("uid://kys0q6fwdcfj"), self)
		status.text = "Benar!!!"
	else : 
		ScreenManager._play_audio(preload("uid://dk1g4ecum1xm5"), self)
		status.text = "Salah!!!"
	await get_tree().create_timer(0.5).timeout
	Global._make_tween(self, "position:y", -1254.0, 1.0)
	await get_tree().create_timer(1.0).timeout
	if benar:
		parent._jawaban_benar(_get_random_fish())
	else :
		parent._jawaban_salah()
	queue_free()

func _get_random_fish() -> Resource:
	var all_fish = Global.used_bait.fish_get.duplicate()
	var total_chance = 0
	for i in all_fish :
		total_chance += i.posibility
	var chance = randf_range(1, total_chance)
	var acumulative = 0
	for i in all_fish :
		acumulative += i.posibility
		if acumulative > chance :
			#print("Accumulative : " + str(acumulative) + ", Chance : " + str(chance))
			return i
	return null
		
