extends CharacterBody2D

@onready var voice = $AudioStreamPlayer2D

@export var min_delay = 3.0
@export var max_delay = 8.0

@export var min_pitch = 0.8
@export var max_pitch = 1.3

@export var speed = 100
@export var direction_change_time := 2.0

@onready var hit_sound = $Hitsound

var direction := Vector2.ZERO

func _ready():
	randomize()
	random_voice_loop()
	random_movement_loop()

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()

func random_movement_loop():
	while true:
		direction = Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		).normalized()

		await get_tree().create_timer(direction_change_time).timeout

func random_voice_loop():
	while true:
		await get_tree().create_timer(randf_range(min_delay, max_delay)).timeout
		
		voice.pitch_scale = randf_range(min_pitch, max_pitch)
		
		if not voice.playing:
			voice.play()


func _on_hurt_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		hit_sound.play()
