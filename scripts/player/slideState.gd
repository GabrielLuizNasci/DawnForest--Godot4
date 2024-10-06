extends State

class_name SlideState

@export var jump_speed = -130.0

@export var landing_state: State
@export var air_state: State

@export var landing_animation: String = "aterrissar"
@export var animacao_salto: String = "salto"

func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state
		playback.travel(landing_animation)

func state_input(event: InputEvent):
	if(event.is_action_pressed("salto")):
		salto()

func on_enter():
	character.emit_signal("gravidade_slide")

func on_exit():
	character.emit_signal("gravidade_normal")

func salto():
	character.velocity.y = jump_speed
	next_state = air_state
	playback.travel(animacao_salto)
