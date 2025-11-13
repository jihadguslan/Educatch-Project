extends Control

@onready var anim: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	anim.play("Pop")
	await anim.animation_finished
	anim.play("Idle")
	
