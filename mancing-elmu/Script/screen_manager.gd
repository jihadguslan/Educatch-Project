extends CanvasLayer

@onready var anim1: AnimationPlayer = $AnimationPlayer
@onready var audioplayer: AudioStreamPlayer = $AudioStreamPlayer

func _change_scene(path_file = "", packed_file : PackedScene = null):
	layer = 10
	anim1.play("Pop In")
	await anim1.animation_finished
	if path_file != "" :
		get_tree().change_scene_to_file(path_file)
	else :
		if packed_file != null :
			get_tree().change_scene_to_packed(path_file)
	anim1.play("Pop Out")
	await anim1.animation_finished
	layer = 0

func _exit_game():
	layer = 10
	anim1.play("Pop In")
	await anim1.animation_finished
	get_tree().quit()

func _play_audio(audiofile : AudioStream, parent):
	var audio_player = preload("uid://bwon72d6l2fsm").instantiate()
	audio_player.stream = preload("uid://bksvvfkrx6ltg")
	parent.add_child(audio_player)

func _play_music(audiofile : AudioStream):
	audioplayer.volume_db = -64.0
	audioplayer.stream = audiofile
	audioplayer.play()
	Global._make_tween(audioplayer, "volume_db", 0.0, 1.0)

func _stop_music():
	Global._make_tween(audioplayer, "volume_db", -64.0, 1.0)
	await get_tree().create_timer(3.0, false, true).timeout
	audioplayer.stop()


func _save_data():
	var save_path = "user://educatch-save.json"
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var save_data = {
		"fish_storage" : Global.fish_storage,
		"bait_left" : Global.bait_left,
		"used_bait" : Global.used_bait.resource_path,
		"coins" : Global.coins
	}
	if file.get_path() == "user://educatch-save.json":
		file.store_var(save_data)
		file.close()

func _load_data():
	var save_path = "user://educatch-save.json"
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var save_data = file.get_var()
		Global.fish_storage = save_data.fish_storage
		Global.bait_left = save_data.bait_left
		Global.used_bait = load(save_data.used_bait)
		Global.coins = save_data.coins
		# Periksa apakah data ada dan sesuai
		if typeof(save_data) == TYPE_DICTIONARY:
			print("Data Loaded")
		else:
			print("Error: Save file is corrupted.")
		file.close()
	else : _save_data()
		

func convert_resources_to_paths(resources: Array):
	var paths = []
	if resources.size() > 0:
		for res in resources:
			paths.append(res.item_path)  # Simpan path dari resource
	return paths

# Fungsi untuk memuat resource dari path
func load_resources_from_paths(paths: Array):
	var resources = []
	if !paths.is_empty():
		for path in paths:
			var res = load(path)
			if res:
				resources.append(res)  # Tambahkan resource yang dimuat ke dalam array
	return resources
