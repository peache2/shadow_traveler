extends Control

@onready var bar = $"../ProgressBar"

func set_health(value: float):
	bar.value = value * 100
