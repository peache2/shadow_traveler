extends Node2D

var current_state: State
var previous_state: State

func _ready():
	# Toma el primer estado como estado inicial
	current_state = get_child(0) as State
	previous_state = current_state
	
	if current_state:
		current_state.enter()
	else:
		push_error("No se encontró un estado inicial en el FSM.")

func change_state(state_name: String):
	# Buscar por nombre exacto
	var new_state = find_child(state_name)

	if new_state == null:
		push_error("Estado no encontrado: " + state_name)
		return

	new_state = new_state as State
	if new_state == null:
		push_error("El nodo '" + state_name + "' no es un State.")
		return

	# Cambio de estado
	if previous_state:
		previous_state.exit()
	
	current_state = new_state
	current_state.enter()
	previous_state = current_state
