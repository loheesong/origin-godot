extends Node

@export var enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$Player.start($StartPosition.position)
	
	var enemy = enemy_scene.instantiate()
	
	var path = $MobPath/MobSpawnLocation
	path.progress_ratio = randf()
	
	enemy.position = path.position
	
	add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
