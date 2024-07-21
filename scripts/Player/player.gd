extends CharacterBody2D
class_name Player

@export var max_speed: int = 200
@export var acceleration: int = 50

@export var jump_force: int = -400

@export var gravity: float = 22
@export var fall_gravity: float = 35

@onready var sprite: Sprite2D =  $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var coyote_timer = $Timers/CoyoteTimer
@onready var jump_buffer_timer = $Timers/JumpBufferTimer


func _physics_process(delta):
	get_input()
	applyGravity()
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_timer.start()
	
func get_input():
	var direction_x = Input.get_axis("Left", "Right")
	velocity.x += direction_x * acceleration
	velocity.x = lerp(velocity.x, 0.0, 0.2)
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.y = clamp(velocity.y, jump_force, 500)
	
	if Input.is_action_just_pressed("Jump"):
		jump_buffer_timer.start()
		if coyote_timer.time_left > 0.0:
			jump()
		
	if (jump_buffer_timer.time_left > 0.0 and is_on_floor()):
		jump()
		print(jump_buffer_timer.time_left)
			
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y = jump_force / 4
			
	if direction_x != 0:
		sprite.flip_h = (direction_x == -1)
	
	animate(direction_x)

func jump():
	velocity.y = jump_force

func getGravity():
	if velocity.y < 0:
		return gravity
	return fall_gravity

func applyGravity():
	if not is_on_floor():
		velocity.y += getGravity()
		
func animate(direction_x):
	if direction_x == 0:
		animation.play("idle")
	else:
		animation.play("run")
	
	if not is_on_floor():
		if velocity.y < 0:
			animation.play("jump")
		else:
			animation.play("fall")
	
		
	
