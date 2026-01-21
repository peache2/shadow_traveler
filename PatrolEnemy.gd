extends CharacterBody2D

const enemyrun = 30
const gravedad = 98

var jugador_en_area: Node2D = null

@onready var area: Area2D = $Area2D
@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $Sprite

func _ready():
	velocity.x = -enemyrun
	sprite.play("Run")

func _physics_process(_delta):
	velocity.y += gravedad

	# Gira al tocar pared, incluso si está atacando
	if is_on_wall():
		if !sprite.flip_h:
			velocity.x = enemyrun
		else:
			velocity.x = -enemyrun

	# Actualiza dirección visual y el área de daño
	if velocity.x < 0:
		sprite.flip_h = false
		area.scale.x = 1
	elif velocity.x > 0:
		sprite.flip_h = true
		area.scale.x = -1

	move_and_slide()
