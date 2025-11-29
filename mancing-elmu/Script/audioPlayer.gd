extends AudioStreamPlayer

func _ready() -> void:
	play()
	print("Audio Played!")
	await finished
	print("Audio Quit!")
	queue_free()
