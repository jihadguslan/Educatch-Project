extends Node


var current_difficulty : SoalResource.DifficultType = 0

var fish_storage : Dictionary = {}
var bait_left : Dictionary = {"PKN" : 5, "MTK" : 5, "ENG" : 5, "IND" : 5, "PAI" : 5}
var used_bait : Resource = preload("uid://iaph6x01fech")
var coins = 10

var sfx_volume = 0.0
var music_volume = 0.0

func _make_tween(obj : Node, property_path : String, value_to, duration : float):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(obj, property_path, value_to, duration)
