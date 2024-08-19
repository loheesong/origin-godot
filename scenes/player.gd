extends Area2D

@export var grid_size = 64

var can_move
signal player_moved(pos)

# Define the RotationDirection enum
enum RotationDirection {
	LEFT,
	RIGHT
}

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
		# handle player movement 
		if event.is_action_pressed(action):
			move(action)

	# Handle rotation with spacebar 
	if event.pressed and event.keycode == KEY_N:
		rotate_enemies(Global.RotationDirection.LEFT)  # Rotate 90 degrees to the right
		
	if event.pressed and event.keycode == KEY_M:
		rotate_enemies(Global.RotationDirection.RIGHT)  # Rotate 90 degrees to the right

func move(action):
	if can_move:
		position += actions[action] * grid_size
		can_move = false
		player_moved.emit(position)
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to rotate enemies
func rotate_enemies(direction: Global.RotationDirection):
	var play_area = get_parent()  # Assuming play_area.gd is the parent node
	play_area.rotate_all_enemies(position, direction)  # Call the function in play_area.gd

func _turn_started() -> void:
	can_move = true
