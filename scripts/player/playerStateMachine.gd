extends Node

class_name CharacterStateMachine

@export var character: CharacterBody2D
@export var current_state: State

var states: Array[State] 

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			
			child.character = character
			
		else:
			push_warning("Filho " + child.name + "Não é um State para CharacterStateMachine")

func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	
	current_state.state_process(delta)

func check_can_move():
	return current_state.can_move

func switch_states(new_state: State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	current_state.on_enter()

func _input(event: InputEvent):
	if(current_state != null):
		current_state.state_input(event)
