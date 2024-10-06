extends State

class_name AttackState

@export var return_state: State
@export var animacao_retorno: String = "mover"
@export var ataque1_nome: String = "ataque1"
@export var ataque2_nome: String = "ataque2"
@export var node_ataque2: String = "ataque2"

@onready var timer: Timer = $Timer

func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func state_input(event: InputEvent):
	if(event.is_action_pressed("ataque")):
		timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == ataque1_nome):
		if(timer.is_stopped()):
			next_state = return_state
			playback.travel(animacao_retorno)
		else:
			playback.travel(node_ataque2)
	
	if(anim_name == ataque2_nome):
		next_state = return_state
		playback.travel(animacao_retorno)
