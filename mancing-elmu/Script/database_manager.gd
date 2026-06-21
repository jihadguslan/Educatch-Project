extends Node

var _bank_soal = {"SD_PKN" : [], "SD_MTK" : [], "SD_ENG" : [], "SD_IND" : [], "SD_PAI" : [], 
"SMP_PKN" : [], "SMP_MTK" : [], "SMP_ENG" : [], "SMP_IND" : [],"SMP_PAI" : [],
"SMA_PKN" : [], "SMA_MTK" : [], "SMA_ENG" : [], "SMA_IND" : [], "SMA_PAI" : []}
var _all_fish = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_bank_soal()
	load_semua_ikan()

func load_bank_soal():
	var path = "res://Soal Res/"
	var dir = DirAccess.open(path)
	if dir :
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var res = load(path + fix_res_name(file_name))
				var id_name = fix_res_name(file_name)
				if res :
					#_bank_soal.append(res)'
					for i in _bank_soal:
						if id_name.begins_with(i):
							_bank_soal[i].append(res)
			file_name = dir.get_next()
		dir.list_dir_end()
		#print(_bank_soal)
	else :
		push_error("Folder tidak ada!!" + path)
	
func load_semua_ikan():
	var path = "res://Ikan Res/"
	var dir = DirAccess.open(path)
	if dir :
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				print(file_name)
				var res = load(path + fix_res_name(file_name))
				if res :
					_all_fish.append(res)
			file_name = dir.get_next()
		dir.list_dir_end()
	else :
		push_error("Folder tidak ada!!" + path)

func fix_res_name(string_name : String) -> String:
	var result
	if string_name.ends_with(".remap"):
		result = string_name.trim_suffix(".remap")
		return result
	return string_name
	
func _get_bank_soal() -> Dictionary:
	return _bank_soal.duplicate()
	
func _get_semua_ikan() -> Array:
	return _all_fish.duplicate()
