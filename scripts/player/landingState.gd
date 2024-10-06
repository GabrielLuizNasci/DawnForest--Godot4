extends State

class_name LandingState

@export var jump_speed = -180.0

#Animações
@export var animacao_salto: String = "salto"
@export var landing_animation: String = "aterrissar"

#Estados
@export var ground_state: State
@export var air_state: State

func state_input(event: InputEvent):
	if(event.is_action_pressed("salto")):
		salto()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == landing_animation):
		next_state = ground_state

func salto():
	character.velocity.y = jump_speed
	next_state = air_state
	playback.travel(animacao_salto)
