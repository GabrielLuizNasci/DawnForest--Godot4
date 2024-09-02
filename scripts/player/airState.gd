extends State

class_name AirState

@export var djump_speed = -150.0
@export var groud_state : State

var double_jump_count : int = 1

func state_process(delta):
	if(character.is_on_floor()):
		next_state = groud_state

func state_input(event: InputEvent):
	if(event.is_action_pressed("salto") && double_jump_count < 2):
		double_jump()

func on_exit():
	if(next_state == groud_state):
		double_jump_count = 1

func double_jump():
	character.velocity.y = djump_speed
	double_jump_count += 1
