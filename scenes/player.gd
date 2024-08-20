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
			
	if event.pressed:
		match event.keycode:
			KEY_N: transform_enemies(Transform2D(-PI/4, position)) #Rotate 45 degrees left
			KEY_M: transform_enemies(Transform2D(PI/4, position)) #Rotate 45 degrees right
			KEY_J: transform_enemies(Transform2D(0, Vector2(0.5, 0.5), 0, position)) #Scale down
			KEY_K: transform_enemies(Transform2D(0, Vector2(1.5, 1.5), 0, position)) #Scale up
			KEY_U: transform_enemies(Transform2D(0, Vector2.ONE, 1, position)) #Skew
			KEY_I: transform_enemies(Transform2D(0, Vector2.ONE, -1, position)) #Skew opposite (u can add more idk)

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

func transform_enemies(transform: Transform2D):
	var play_area = get_parent()  # Assuming play_area.gd is the parent node
	play_area.transform_all_enemies(transform)  # Call the function in play_area.gd

func _turn_started() -> void:
	can_move = true
