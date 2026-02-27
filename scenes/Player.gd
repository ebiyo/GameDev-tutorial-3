extends CharacterBody2D

@export var gravity = 800.0
@export var walk_speed = 300
@export var jump_speed = -400
@export var jump_times = 0
@export var crouch_speed = 150
var is_crouching = false

@onready var collshape = $CollisionShape2D
@onready var sprite = $Sprite2D

@export var idle_texture : Texture2D
@export var crouch_texture : Texture2D
@export var walk_texture : Texture2D
@export var jump_texture : Texture2D

@export var dash_speed = 900
@export var dash_time = 0.2
@export var double_tap_window = 0.25

var is_dashing = false
var dash_timer = 0.0

var last_tap_time_left = 0.0
var last_tap_time_right = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func start_dash(direction):
	is_dashing = true
	dash_timer = dash_time
	velocity.x = direction * dash_speed

func _physics_process(delta):
	velocity.y += delta * gravity
	dash_timer -= delta
	
	if is_on_floor():
		jump_times = 2
		
	if Input.is_action_pressed("crouch") and is_on_floor():
		is_crouching = true
	else:
		is_crouching = false
	
	# Disable jump while crouching
	if Input.is_action_just_pressed('ui_up') and jump_times > 0 and not is_crouching:
		velocity.y = jump_speed
		jump_times -= 1
	
	if is_dashing:
		velocity.x = sign(velocity.x) * dash_speed
		if dash_timer <= 0:
			is_dashing = false
		move_and_slide()
		return
	var current_time = Time.get_ticks_msec() / 1000.0

	if Input.is_action_just_pressed("ui_left"):
		if current_time - last_tap_time_left <= double_tap_window:
			start_dash(-1)
		last_tap_time_left = current_time

	if Input.is_action_just_pressed("ui_right"):
		if current_time - last_tap_time_right <= double_tap_window:
			start_dash(1)
		last_tap_time_right = current_time
		
	if Input.is_action_pressed("ui_left"):
		if is_crouching:
			velocity.x = -crouch_speed
		else:
			velocity.x = -walk_speed
		sprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		if is_crouching:
			velocity.x = crouch_speed
		else:
			velocity.x = walk_speed
		sprite.flip_h = false
	else:
		velocity.x = 0
		
	# Change sprite
	if is_crouching:
		sprite.texture = crouch_texture
	elif not is_on_floor():
		sprite.texture = jump_texture
	elif velocity.x != 0:
		sprite.texture = walk_texture
	else:
		sprite.texture = idle_texture
	
	# "move_and_slide" already takes delta time into account.
	move_and_slide()
