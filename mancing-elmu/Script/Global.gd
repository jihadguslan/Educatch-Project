extends Node

var fish_storage : Dictionary = {}
var bait_left : Dictionary = {"PKN" : 5, "MTK" : 5, "ENG" : 5, "IND" : 5}
var used_bait : Resource = preload("res://Bait Res/Bait PKN.tres")
var coins = 10

func _make_tween(obj : Node, property_path : String, value_to, duration : float):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(obj, property_path, value_to, duration)
