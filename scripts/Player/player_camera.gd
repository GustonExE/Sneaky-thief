extends Camera2D

@onready var player = $"../Player"

# Variables for camera look ahead
var look_ahead_offset = Vector2(50, 0)  # Adjust the offset as needed
var look_ahead_smoothing = 0.1  # Adjust the smoothing as needed

func _ready():
	position_smoothing_enabled = true
	drag_horizontal_enabled = true
	drag_vertical_enabled = true
	zoom = Vector2(0.8, 0.8)

func _physics_process(delta):
	var target_position = player.position

	# Adjust the target position based on player's facing direction
	if player.sprite.flip_h:
		target_position -= look_ahead_offset
	else:
		target_position += look_ahead_offset

	# Smoothly interpolate the camera position towards the target position
	position = position.lerp(target_position, look_ahead_smoothing)

	position_smoothing_speed = 10
	drag_top_margin = 0.45

func camera_damping():
	if player.flip_h:
		offset.x = lerp(offset.x, -30, 0.5)
	else:
		offset.x = lerp(offset.x, 30, 0.5)
