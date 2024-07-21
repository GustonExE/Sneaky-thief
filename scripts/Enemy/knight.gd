extends CharacterBody2D
class_name Knight

@export var max_speed = 50
@export var acceleration = 50

@export var gravity = 22

var direction = -1
var wander_time: float

@onready var raycast: RayCast2D = $RayCast
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready():
	raycast.enabled = true

func _physics_process(delta):
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.y = clamp(velocity.y, 0, 500)
	if not is_on_floor():
		applyGravity()
	animate()
	
	move_and_slide()

func found_legde():
	return !raycast.is_colliding()
func found_wall():
	return is_on_wall()

func applyGravity():
	velocity.y += gravity

func animate():
	if velocity.x == 0:
		animation.play("idle")
	else:
		animation.play("run")
