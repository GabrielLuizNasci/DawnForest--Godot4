extends State

class_name GroundState

@export var jump_speed = -180.0

#Estados
@export var air_state: State
@export var attack_state: State

#Animações
@export var animacao_salto: String = "salto"
@export var animacao_ataque: String = "ataque1"

var jump_cont: int = 0

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event: InputEvent):
	if(event.is_action_pressed("salto")):
		salto()
	if(event.is_action_pressed("ataque")):
		ataque()

func salto():
	character.velocity.y = jump_speed
	next_state = air_state
	playback.travel(animacao_salto)

func ataque():
	next_state = attack_state
	playback.travel(animacao_ataque)
