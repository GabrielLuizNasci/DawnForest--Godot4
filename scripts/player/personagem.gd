extends CharacterBody2D

class_name Player

#Variáveis para player
var saude = 100
var player_vivo = true
signal gravidade_normal
signal gravidade_slide

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var maquina_estado: CharacterStateMachine = $CharacterStateMachine

# Variáveis relacionadas a velocidade e movimentação
var direcao_atual: String = "nenhuma"
var direcao_input = Vector2(0,0)
@export var speed = 100.0
var ultima_direcao_horizontal = 1

# Variáveis relacionadas a salto
@export var player_gravity = 1000
var landing: bool = false


func _ready():
	animation_tree.active = true

func _process(_delta):
	animation_tree.set("parameters/mover/blend_position", direcao_input.x)
	direcao_input = Input.get_vector("esquerda","direita","salto","agachamento")
		
	if(direcao_input.length() > 0):
		if (direcao_input.x == 1):
			sprite.flip_h = false
			ultima_direcao_horizontal = 1
			direcao_atual = "direita"
		elif (direcao_input.x == -1):
			sprite.flip_h = true
			ultima_direcao_horizontal = -1
			direcao_atual = "esquerda"
	else:
		sprite.flip_h = ultima_direcao_horizontal == -1

func _physics_process(delta):
	controle_movimento_horizontal()
	gravity(delta)
	
	move_and_slide()
	
	if(saude <= 0):
		player_vivo = false
		saude = 0
		print("Jogador Morto")

func controle_movimento_horizontal() -> void:
	var input_direction: float = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	
	if( input_direction != 0 && maquina_estado.check_can_move()):
		velocity.x = input_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func gravity(delta: float) -> void:
	velocity.y += player_gravity * delta
	if velocity.y >= player_gravity:
		velocity.y = player_gravity

func player():
	pass
