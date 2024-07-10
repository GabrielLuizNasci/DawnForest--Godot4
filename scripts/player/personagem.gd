extends CharacterBody2D

class_name Player

#Variáveis de Nimigo
var inimigo_emalcance = false
var inimigo_recarga_ataque = true

#Variáveis para player
var saude = 100
var player_vivo = true
var ataque_em_andamento = false



# Variáveis relacionadas a velocidade e movimentação
var direcao_atual: String = "nenhuma"
var direcao_input = Vector2(0,0)
@export var speed = 100.0
var ultima_direcao_horizontal = 1

# Variáveis relacionadas a salto
@export var jump_speed = -400.0
@export var player_gravity = 1000
var jump_cont: int = 0
var landing: bool = false


func _ready():
	pass
	# Conecta o sinal "landed" à função on_landed
	#connect("landed", Callable(self, "on_landed"))
	#$AnimatedSprite2D.connect("animation_finished", Callable(self, "_on_animated_sprite_2d_animation_finished"))

func _process(_delta):
	direcao_input = Input.get_vector("esquerda","direita","salto","agachamento")
	
	if(ataque_em_andamento == true and global.jogador_atacando == true):
		$AnimatedSprite2D.play("ataque_esquerda")
		$AnimatedSprite2D.flip_h = ultima_direcao_horizontal == -1
	elif(not is_on_floor() and velocity.y < 0):
		$AnimatedSprite2D.play("saltar")
	elif(not is_on_floor() and velocity.y > 0):
		$AnimatedSprite2D.play("cair")
	else:
		if(direcao_input.length() > 0):
			if (direcao_input.y == 1):
				$AnimatedSprite2D.play("agachar")
			if (direcao_input.x == 1):
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("corrida")
				ultima_direcao_horizontal = 1
				direcao_atual = "direita"
			elif (direcao_input.x == -1):
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("corrida")
				ultima_direcao_horizontal = -1
				direcao_atual = "esquerda"
		else:
			$AnimatedSprite2D.play("idle")
			$AnimatedSprite2D.flip_h = ultima_direcao_horizontal == -1

func _physics_process(delta):
	controle_movimento_horizontal()
	controle_movimento_vertical()
	gravity(delta)
	
	move_and_slide()
	
	if(Input.is_action_just_pressed("ataque")):
		controle_ataque()
	
	if(saude <= 0):
		player_vivo = false
		saude = 0
		print("Jogador Morto")

func on_landed():
	$AnimatedSprite2D.play("aterrissar") 

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

func controle_ataque():
	var direc: String = direcao_atual
	
	global.jogador_atacando = true
	ataque_em_andamento = true
	$AttackCooldown.start()

func gravity(delta: float) -> void:
	# Add the gravity.
	velocity.y += player_gravity * delta
	if velocity.y >= player_gravity:
		velocity.y = player_gravity

func player():
	pass

func _on_area_ataque_body_entered(body):
	if body.has_method("inimigo"):
		inimigo_emalcance = true

func _on_area_ataque_body_exited(body):
	if body.has_method("inimigo"):
		inimigo_emalcance = false

func ataque_inimigo():
	if inimigo_emalcance and inimigo_recarga_ataque == true:
		saude = saude - 10
		inimigo_recarga_ataque = false
		$DamageCooldown.start()
		print(saude)

func _on_damage_cooldown_timeout():
	inimigo_recarga_ataque = true

func _on_animated_sprite_2d_animation_finished():
	if($AnimatedSprite2D.animation == "ataque_esquerda"):
		global.jogador_atacando = false

func _on_attack_cooldown_timeout():
	$DamageCooldown.stop()
	global.jogador_atacando = false
	ataque_em_andamento = false
