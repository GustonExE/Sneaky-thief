extends State
class_name EnemyIdle

@export var enemy: Knight
var player = CharacterBody2D

func randomize_wander():
	enemy.wander_time = randf_range(5, 15)
	
func enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func update(_delta: float):
	if enemy.wander_time > 0:
		enemy.wander_time -= _delta
	else:
		randomize_wander()
		
func physics_update(delta: float):
	if enemy.found_legde() or enemy.found_wall():
		enemy.direction *= -1
		enemy.velocity.x = 0  # Reset velocity when changing direction to avoid instant speed gain
		
	enemy.velocity.x += enemy.direction * enemy.acceleration
	enemy.max_speed = 50
	enemy.sprite.flip_h = (enemy.direction == -1)
	enemy.raycast.position.x = 5 * enemy.direction
	var direction_x = player.global_position.x - enemy.global_position.x
	
	if abs(direction_x) < 30:
		transitioned.emit(self, "Follow")
	
	
	
	
