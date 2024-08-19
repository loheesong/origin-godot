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
