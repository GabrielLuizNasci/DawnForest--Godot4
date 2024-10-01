extends State

class_name GroundState

@export var jump_speed = -180.0

#Estados
@export var air_state: State
@export var attack_state: State
@export var defense_state: State
@export var crouch_state: State

#Animações
@export var animacao_salto: String = "salto"
@export var animacao_ataque: String = "ataque1"
@export var animacao_defesa: String = "defesa"
@export var animacao_agachar: String = "agachar"

var jump_cont: int = 0

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event: InputEvent):
	if(event.is_action_pressed("salto")):
		salto()
	if(event.is_action_pressed("ataque")):
		ataque()
	if(event.is_action_pressed("defesa")):
		defesa()
	if(event.is_action_pressed("agachamento")):
		agachar()

func salto():
	character.velocity.y = jump_speed
	next_state = air_state
	playback.travel(animacao_salto)

func ataque():
	next_state = attack_state
	playback.travel(animacao_ataque)

func defesa():
	next_state = defense_state
	playback.travel(animacao_defesa)

func agachar():
	next_state = crouch_state
	playback.travel(animacao_agachar)
