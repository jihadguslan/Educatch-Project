extends Node

var fish_storage : Dictionary = {}
var bait_left : Dictionary = {"PKN" : 0, "MTK" : 0, "INGGRIS" : 0, "INDONESIA" : 0}
var used_bait : Dictionary = {"id" : "MTK", "res" : preload("uid://cwhv26ygy24nm")}
var coins = 5

func _make_tween(obj : Node, property_path : String, value_to, duration : float):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(obj, property_path, value_to, duration)
