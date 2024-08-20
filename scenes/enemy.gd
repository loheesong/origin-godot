extends Area2D

@export var grid_size = 16
var dest: Vector2
var moving_to_player = false
signal killed_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		if moving_to_player:
			killed_player.emit()


func _on_player_moved(pos: Vector2) -> void:
	dest = pos


func _on_enemy_turn_started() -> void:
	moving_to_player = true
	move_towards_player()
	moving_to_player = false
	
func move_towards_player() -> void:
	var dir = position.direction_to(dest)
	if abs(dir.aspect())>1:
		position += Vector2(dir.x, 0).normalized() * grid_size
	else:
		position += Vector2(0, dir.y).normalized() * grid_size
