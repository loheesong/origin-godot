extends Node

@export var enemy_scene: PackedScene
enum {PLAYER, ENEMY}

var turn
signal player_turn_started
signal enemy_turn_started

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.start(Vector2(8, 8))
	
	var turn = PLAYER
	
	var enemy = enemy_scene.instantiate()
	var path = $MobPath/MobSpawnLocation
	path.progress_ratio = randf()
	enemy.position = path.position
	add_child(enemy)
	
	player_turn_started.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_moved(_pos) -> void:
	await get_tree().create_timer(0.5).timeout
	enemy_turn_started.emit()
	player_turn_started.emit()
	
# Function to rotate all enemies around the player's position
func rotate_all_enemies(player_position: Vector2, direction: Global.RotationDirection):
	var enemies = get_tree().get_nodes_in_group("enemies")  # Assuming your enemies are in a group called "enemies"
	for enemy in enemies:
		rotate_enemy_around_player(enemy, player_position, direction)

# Rotate a single enemy
func rotate_enemy_around_player(enemy: Node2D, player_position: Vector2, direction: Global.RotationDirection):
	var relative_position = enemy.position - player_position
	
	var new_position: Vector2
	
	if direction == Global.RotationDirection.RIGHT:
		new_position = Vector2(relative_position.y, -relative_position.x)
	elif direction == Global.RotationDirection.LEFT:
		new_position = Vector2(-relative_position.y, relative_position.x)
	
	enemy.position = new_position + player_position
