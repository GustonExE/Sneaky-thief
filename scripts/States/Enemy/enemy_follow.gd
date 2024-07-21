extends State
class_name EnemyFollow

@export var enemy: Knight
var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")

func physics_update(delta: float):
	var direction_x = player.global_position.x - enemy.global_position.x
		
	if abs(direction_x) > 15:
		enemy.velocity.x = sign(direction_x) * enemy.max_speed
	else:
		enemy.velocity.x = 0
		
	enemy.sprite.flip_h = (sign(direction_x) == -1)
	
	if abs(direction_x) > 50:
		transitioned.emit(self, "idle")
		




