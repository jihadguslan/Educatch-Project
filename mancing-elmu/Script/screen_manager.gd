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
