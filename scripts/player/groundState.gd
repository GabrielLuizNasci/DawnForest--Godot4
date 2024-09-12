extends State

class_name GroundState

@export var jump_speed = -180.0
@export var air_state = State
@export var animacao_salto: String = "salto"

var jump_cont: int = 0

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event: InputEvent):
	if(event.is_action_pressed("salto")):
		salto()

func salto():
	character.velocity.y = jump_speed
	next_state = air_state
	playback.travel(animacao_salto)
