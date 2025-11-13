extends Node

var fish_storage : Dictionary = {}
var coins = 5

func _make_tween(obj : Node, property_path : String, value_to, duration : float):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(obj, property_path, value_to, duration)
