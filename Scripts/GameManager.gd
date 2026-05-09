extends Node

signal health_changed(current_health)

var max_health: float = 3.0
var current_health: float = 3.0

func take_damage(amount: float):
	current_health -= amount
	current_health = max(0, current_health)
	health_changed.emit(current_health)
