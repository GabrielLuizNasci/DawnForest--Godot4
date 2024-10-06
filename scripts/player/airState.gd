extends State

class_name AirState

@onready var wall_ray: RayCast2D
var on_wall: bool = false

@export var djump_speed = -180.0

@export var landing_state: State
@export var slide_state: State

@export var animacao_saltod: String = "salto_duplo"
@export var landing_animation: String = "aterrissar"
@export var sliding_animation: String = "wall_slide"

var double_jump_count: int = 1

func state_process(delta):
	wall_ray = character.get_node("WallRay")
	if(character.is_on_wall() and not character.is_on_floor()):
		next_state = slide_state
		playback.travel(sliding_animation)
	if(character.is_on_floor()):
		next_state = landing_state


func state_input(event: InputEvent):
	if(event.is_action_pressed("salto") && double_jump_count < 2):
		double_jump()
	if(event.is_action_released("salto")):
		character.velocity.y = lerp(character.velocity.y, 0.0, 0.9)

func on_exit():
	if(next_state == landing_state):
		playback.travel(landing_animation)
		double_jump_count = 1

func double_jump():
	character.velocity.y = djump_speed
	double_jump_count += 1
	playback.travel(animacao_saltod)
