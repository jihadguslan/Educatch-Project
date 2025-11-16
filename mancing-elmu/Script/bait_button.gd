extends Button

signal _send_data(data : Dictionary)

var res
var total = 0

func prepare() :
	total = Global.bait_left[res.kode_soal]
	icon = res.bait_image
	text = str(total)
	
func _on_button_up() -> void:
	emit_signal("_send_data", {"Res" : res, "button_node" : self})
