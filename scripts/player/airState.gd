extends State

class_name AirState

@export var djump_speed = -150.0
@export var landing_state : State
@export var animacao_saltod: String = "salto_duplo"

var double_jump_count : int = 1

func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state

func state_input(event: InputEvent):
	if(event.is_action_pressed("salto") && double_jump_count < 2):
		double_jump()

func on_exit():
	if(next_state == landing_state):
		double_jump_count = 1

func double_jump():
	character.velocity.y = djump_speed
	double_jump_count += 1
	playback.travel(animacao_saltod)
