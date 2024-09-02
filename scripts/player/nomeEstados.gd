extends Label

@export var state_machine: CharacterStateMachine


func _process(delta):
	text = "Estado: " + state_machine.current_state.name
