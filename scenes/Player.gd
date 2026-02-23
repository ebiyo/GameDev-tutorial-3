extends CharacterBody2D

@export var gravity = 800.0
@export var walk_speed = 300
@export var jump_speed = -400
@export var jump_times = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta):
	velocity.y += delta * gravity
	
	if is_on_floor():
		jump_times = 2
	
	if Input.is_action_just_pressed('ui_up') && jump_times > 0:
		velocity.y = jump_speed
		jump_times -= 1
		
	if Input.is_action_pressed("ui_left"):
		velocity.x = -walk_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  walk_speed
	else:
		velocity.x = 0
	# "move_and_slide" already takes delta time into account.
	move_and_slide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
