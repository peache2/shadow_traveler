extends CanvasLayer

@onready var boton_continuar = $VBoxContainer/Continue
@onready var boton_salir = $"VBoxContainer/Main Menu"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS 
	layer = 128 # 
	hide() 
	
	boton_continuar.pressed.connect(_on_continuar_pressed)
	boton_salir.pressed.connect(_on_salir_pressed)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if get_tree().current_scene.name == "MenuPrincipal":
			return
		
		alternar_pausa()

func alternar_pausa():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused
	
	if visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_continuar_pressed():
	alternar_pausa()

func _on_salir_pressed():
	get_tree().paused = false
	hide()
	get_tree().change_scene_to_file("res://Scenes/menu_principal.tscn")
