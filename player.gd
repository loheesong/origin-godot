extends Area2D

@export var grid_size = 64

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
const actions = {
	"move_left": Vector2.LEFT,
	"move_right": Vector2.RIGHT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}
func _unhandled_key_input(event: InputEvent) -> void:
	for action in actions:
		if event.is_action_pressed(action):
			move(action)
			
func move(action):
	position += actions[action] * grid_size

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
