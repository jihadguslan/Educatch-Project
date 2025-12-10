extends CharacterBody2D

@export var min_speed := 40.0
@export var max_speed := 120.0

@export var steering_force := 2.5
@export var wall_avoid_force := 4.0
@export var fish_avoid_force := 3.0

@export var slow_down_dist := 90.0

@export var texture : Texture2D

var target_speed := 0.0

var wander_angle := 0.0
var wander_timer := 0.0

@onready var wall_ray = $WallRay
@onready var fish_detector = $FishDetector
@onready var sprite = $Sprite2D


func _ready():
	randomize()
	target_speed = randf_range(min_speed, max_speed)
	velocity = Vector2.RIGHT * target_speed
	sprite.texture = texture

func _physics_process(delta):
	var desired_dir = _get_desired_direction(delta)
	var desired_vel = desired_dir * target_speed

	# Steering: gerak diarahkan perlahan (smooth belok)
	velocity = velocity.lerp(desired_vel, steering_force * delta)
	
	move_and_slide()

	_update_flip()


# =========================
# ARAH UTAMA
# =========================

func _get_desired_direction(delta) -> Vector2:
	var dir = velocity.normalized()
	_update_wander(delta)
	# Gerakan santai naik/turun
	
	dir = dir.rotated(wander_angle)

	# Hindari tembok
	dir += _avoid_wall()

	# Hindari ikan lain
	dir += _avoid_fish()

	return dir.normalized()


# =========================
# WANDER (NAIK TURUN)
# =========================

func _update_wander(delta):
	wander_timer -= delta
	if wander_timer <= 0:
		wander_timer = randf_range(1.0, 3.0)
		wander_angle = randf_range(-0.4, 0.4)


# =========================
# WALL AVOID
# =========================

func _avoid_wall() -> Vector2:
	wall_ray.target_position = velocity.normalized() * slow_down_dist

	if wall_ray.is_colliding():
		var normal = wall_ray.get_collision_normal()
		return normal * wall_avoid_force

	return Vector2.ZERO


# =========================
# FISH AVOID
# =========================

func _avoid_fish() -> Vector2:
	var force = Vector2.ZERO
	var bodies = fish_detector.get_overlapping_bodies()

	for b in bodies:
		if b != self and b.is_in_group("fish"):
			var away = global_position - b.global_position
			var dist = away.length()

			if dist > 0:
				force += away.normalized() / dist

	return force * fish_avoid_force


# =========================
# FLIP SPRITE (DIBALIK)
# =========================

func _update_flip():
	if velocity.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
