extends State

class_name CrouchState

@export var jump_speed = -180.0

@export var return_state: State
@export var air_state: State

@export var animacao_agachar: String = "agachar"
@export var animacao_retorno: String = "mover"
@export var animacao_salto: String = "salto"

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func state_input(event: InputEvent):
	if(event.is_action_pressed("agachamento")):
		playback.travel(animacao_agachar)
	elif(event.is_action_pressed("salto")):
		character.velocity.y = jump_speed
		next_state = air_state
		playback.travel(animacao_salto)
	elif(event.is_action_released("agachamento")):
		next_state = return_state
		playback.travel(animacao_retorno)
