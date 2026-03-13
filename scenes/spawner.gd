extends Node2D

@export var obstacle : PackedScene
@export var spawn_interval := 1.5
@export var max_bees := 10
@export var bee_lifetime := 15.0

var current_bees := 0

func _ready():
	spawn_loop()

func spawn():
	if current_bees >= max_bees:
		return

	var spawned = obstacle.instantiate()
	get_parent().add_child(spawned)

	var spawn_pos = global_position
	spawn_pos.x += randf_range(-1000, 1000)
	spawn_pos.y += randf_range(-200, 200)

	spawned.global_position = spawn_pos

	current_bees += 1

	# Despawn after some time
	despawn_later(spawned)

func despawn_later(bee):
	await get_tree().create_timer(bee_lifetime).timeout
	if is_instance_valid(bee):
		bee.queue_free()
		current_bees -= 1

func spawn_loop():
	while true:
		spawn()
		await get_tree().create_timer(spawn_interval).timeout
