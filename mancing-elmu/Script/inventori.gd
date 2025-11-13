extends Control

@onready var box: FlowContainer = $Control/Scroll/FlowContainer
@onready var sell: Button = $Control/HBoxContainer/Sell
@onready var coins: Label = $Control/Coins

var parent
var hold_fish

func _ready() -> void:
	Global._make_tween(self, "position:y", 0.0, 0.8)
	sell.hide()
	coins.text = "Coins : " + str(Global.coins)
	_fill_box()
	
func _on_back_button_up() -> void:
	Global._make_tween(self, "position:y", 800.0, 0.8)
	await get_tree().create_timer(0.8, false, true).timeout
	parent.close_page()

func _fill_box():
	if box.get_child_count() > 0:
		for i in box.get_children():
			i.queue_free()
	for i in Global.fish_storage:
		for j in DatabaseManager._all_fish:
			if j.nama_ikan == i:
				if Global.fish_storage[i] > 0 :
					for k in range(Global.fish_storage[i]):
						var inst = preload("uid://3tvuewgror1e").instantiate()
						inst.res = j
						inst.unlock = true
						inst._send_data.connect(_receive_data)
						box.add_child(inst)


func _receive_data(data, unlock):
	sell.show()
	sell.text = "Jual " + str(data.resource.harga_ikan)
	hold_fish = data

func _on_sell_button_up() -> void:
	Global.coins += hold_fish.resource.harga_ikan
	coins.text = "Coins : " + str(Global.coins)
	for i in Global.fish_storage:
		print(i)
		if i == hold_fish.resource.nama_ikan :
			Global.fish_storage[i] -= 1
			#if Global.fish_storage[i] < 1:
				#Global.fish_storage.erase()
	#hold_fish.node_button.queue_free()
	_fill_box()
	sell.hide()
	hold_fish = null
