extends Control

signal _send_data(data : Dictionary, unlock : bool)
@onready var button: Button = $AnchorAnim/button
@onready var anchor_anim: Control = $AnchorAnim

var res : Resource
var unlock = false
var button_tex = ["res://Asset/base_button (large).png", "res://Asset/base_button_green (large).png",
"res://Asset/base_button_yellow (large).png", "res://Asset/base_button_purple (large).png"]
const click_sound = preload("uid://bpdxwfq1aukv")

func _ready() -> void:
	if unlock:
		button.icon = res.image_ikan
		#button.text = res.nama_ikan
	else :
		button.icon = preload("res://Asset/Unknown fish.png")
		#button.text = "???"
	_rarity_button()

func _rarity_button():
	##button.get_theme_stylebox("normal").duplicate(true)
	button.get_theme_stylebox("normal").texture = load(button_tex[res.rarity])
	button.get_theme_stylebox("pressed").texture = load(button_tex[res.rarity])
	button.get_theme_stylebox("hover").texture = load(button_tex[res.rarity])
	button.get_theme_stylebox("disabled").texture = load(button_tex[res.rarity])


func _on_button_ensik_button_up() -> void:
	ScreenManager._play_audio(click_sound, self)
	if unlock :
		emit_signal("_send_data", {"resource" : res.duplicate(), "node_button" : self}, true)
	else: 
		emit_signal("_send_data", {"resource" : res.duplicate(), "node_button" : self}, false)

func _on_button_mouse_entered() -> void:
	Global._make_tween(anchor_anim, "scale", Vector2(1.1, 1.1), 0.2)

func _on_button_mouse_exited() -> void:
	Global._make_tween(anchor_anim, "scale", Vector2(1.0, 1.0), 0.2)
