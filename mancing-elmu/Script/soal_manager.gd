extends Control

@onready var soal: Label = $Panel/Soal
@onready var button_group = [$Panel/VBoxContainer/Pilgan1/A, $Panel/VBoxContainer/Pilgan2/B, $Panel/VBoxContainer/Pilgan1/C, $Panel/VBoxContainer/Pilgan2/D]
@onready var status: Label = $Panel/status
@onready var box: VBoxContainer = $Panel/VBoxContainer

var soal_res : Resource
var parent

func _ready() -> void:
	box.show()
	parent = find_parent("Player")
	soal.text = soal_res.isi_soal
	for i in range(button_group.size()):
		button_group[i].text = soal_res.pilihan_soal[i]
	Global._make_tween(self, "position:y", 0.0, 1.2)

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
	if benar: status.text = "Benar!!!"
	else : status.text = "Salah!!!"
	await get_tree().create_timer(0.5).timeout
	Global._make_tween(self, "position:y", -1254.0, 1.0)
	await get_tree().create_timer(1.0).timeout
	if benar:
		parent._jawaban_benar(_get_random_fish())
	else :
		parent._jawaban_salah()
	queue_free()

func _get_random_fish() -> Resource:
	var all_fish = DatabaseManager._all_fish.duplicate()
	var total_chance = 0
	for i in all_fish :
		total_chance += i.posibility
	var chance = randf_range(1, total_chance)
	var acumulative = 0
	for i in all_fish :
		acumulative += i.posibility
		if acumulative > chance :
			#print("Accumulative : " + str(acumulative) + ", Chance : " + str(chance))
			return i.duplicate()
	return null
		
