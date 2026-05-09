extends CanvasLayer

@onready var corazones = [$HBoxContainer/Hearth, $HBoxContainer/Hearth2, $HBoxContainer/Hearth3]

func _ready():
	GameManager.health_changed.connect(actualizar_interfaz)
	actualizar_interfaz(GameManager.current_health)

func actualizar_interfaz(salud_actual: float):
	var mitades_totales = int(salud_actual * 2)
	
	for i in range(corazones.size()):
		var barra = corazones[i]
		if mitades_totales >= 2:
			barra.value = 2
			mitades_totales -= 2
		elif mitades_totales == 1:
			barra.value = 1
			mitades_totales -= 1
		else:
			barra.value = 0
