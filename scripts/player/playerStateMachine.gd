extends Node

class_name CharacterStateMachine

@export var player: CharacterBody2D
@export var estado_atual: State

var states: Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			
			
			
		else:
			push_warning("Filho " + child.name + "Não é um State para CharacterStateMachine")

func check_pode_mover():
	return estado_atual.pode_mover
