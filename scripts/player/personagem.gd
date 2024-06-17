extends CharacterBody2D

class_name Player

var direcao_input = Vector2(0,0)

# Variáveis relacionadas a velocidade e movimentação
@export var speed = 100.0
var ultima_direcao_horizontal = 1

# Variáveis relacionadas a salto
@export var jump_speed = -400.0
@export var player_gravity = 1000
var jump_cont: int = 0
var landing: bool = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# var gravity = 1000

func _process(_delta):
	direcao_input = Input.get_vector("esquerda","direita","salto","agachamento")
	if(direcao_input.length() > 0):
		if (direcao_input.y == -1):
			$AnimatedSprite2D.play("saltar")
		elif (direcao_input.y == 1):
			$AnimatedSprite2D.play("agachar")
		if (direcao_input.x == 1):
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("corrida")
			ultima_direcao_horizontal = 1
		elif (direcao_input.x == -1):
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("corrida")
			ultima_direcao_horizontal = -1
	else:
		$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.flip_h = ultima_direcao_horizontal == -1

func _physics_process(delta):
	controle_movimento_horizontal()
	controle_movimento_vertical()
	gravity(delta)
	# Handle jump.
	# if Input.is_action_just_pressed("salto") and is_on_floor():
		# velocity.y = JUMP_VELOCITY
	
	move_and_slide()

func controle_movimento_horizontal() -> void:
	var input_direction: float = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	
	velocity.x = input_direction * speed
	
	if(is_zero_approx(input_direction)):
		# Aplica desaceleração quando não há input
		velocity.x = lerp(velocity.x, 0.0, 0.1)

func controle_movimento_vertical() -> void:
	if is_on_floor():
		jump_cont = 0
	
	if Input.is_action_just_pressed("salto") and jump_cont < 2:
		jump_cont += 1
		velocity.y = jump_speed

func gravity(delta: float) -> void:
	# Add the gravity.
	velocity.y += player_gravity * delta
	if velocity.y >= player_gravity:
		velocity.y = player_gravity
