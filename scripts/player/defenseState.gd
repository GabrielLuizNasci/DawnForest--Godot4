extends State

class_name DefenseState

@export var return_state: State
@export var attack_state: State

@export var animacao_retorno: String = "mover"
@export var animacao_defesa: String = "defesa"
@export var animacao_ataque: String = "ataque1"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func state_input(event: InputEvent):
	if(event.is_action_pressed("defesa")):
		playback.travel(animacao_defesa)
	elif(event.is_action_pressed("ataque")):
		next_state = attack_state
		playback.travel(animacao_ataque)
	elif(event.is_action_released("defesa")):
		next_state = return_state
		playback.travel(animacao_retorno)
