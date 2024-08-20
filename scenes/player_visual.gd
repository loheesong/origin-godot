extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	position = get_parent().position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = lerp(position, get_parent().position, delta*10)
