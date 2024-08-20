extends Node

@export var enemy_scene: PackedScene
enum {PLAYER, ENEMY}

var turn
var spawnConter = 0 #Conut down till enemy spwan
const spawnRate = 3
signal player_turn_started
signal enemy_turn_started

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.start(Vector2(8, 8))
	
	var turn = PLAYER
	
	var enemy = enemy_scene.instantiate()
	
	player_turn_started.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_moved(_pos) -> void:
	await get_tree().create_timer(0.5).timeout
	enemy_turn_started.emit()
	player_turn_started.emit()
	if spawnConter == 0:
		spawn_enemy()
		spawnConter = spawnRate
	else:
		spawnConter -= 1
	
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

#spawn enemy
func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	var rng := RandomNumberGenerator.new()
	var widthStart = $TileMap.size.position[0]
	var widthEnd = widthStart + $TileMap.size.size[0]
	var random_x = rng.randi_range(widthStart, widthEnd)
	var random_y = rng.randi_range(0, 1)
	if random_y == 0:
		random_y = $TileMap.size.position[1]+0.5
	else:
		random_y = $TileMap.size.end[1]-0.5
	enemy.position = Vector2(random_x-0.5, random_y) * 16
	enemy_turn_started.connect(enemy._on_enemy_turn_started)
	$Player.player_moved.connect(enemy._on_player_moved)
	add_child(enemy)
	
