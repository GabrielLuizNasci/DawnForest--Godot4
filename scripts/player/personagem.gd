extends CharacterBody2D

class_name Player

var direcao_input = Vector2(0,0)
@export var SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 1000

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
		elif (direcao_input.x == -1):
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("corrida")
	else:
		$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	if(direcao_input.length() > 0):
		velocity = direcao_input * SPEED
		#position.x = clamp(position.x, 0, get_viewport_rect().size.x)
		#position.y = clamp(position.y, 0, get_viewport_rect().size.y)
	else:
		# Aplica desaceleração quando não há input
		velocity.x = lerp(velocity.x, 0.0, 0.1)
		velocity.y = lerp(0.0, velocity.y, 0.2)
	print(direcao_input)
 
	# Handle jump.
	if Input.is_action_just_pressed("salto") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var movimento_horizontal: float = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	#if Input.is_action_just_pressed("esquerda") or Input.is_action_just_pressed("direita"):

		
	
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
	
	move_and_slide()
