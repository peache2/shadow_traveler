extends CharacterBody2D

const enemyrun = 60
const gravedad = 98

var jugador_en_area: Node2D = null

@onready var area: Area2D = $Area2D
@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var ray_suelo: RayCast2D = $Floor

func _ready():
	velocity.x = -enemyrun
	sprite.play("Run")

func _physics_process(_delta):
	# Gravedad
	velocity.y += gravedad

	# Gira si toca pared o si no hay suelo adelante
	if is_on_wall() or !ray_suelo.is_colliding():
		velocity.x *= -1

	# Dirección visual + área + raycast
	if velocity.x < 0:
		sprite.flip_h = false
		area.scale.x = 1
		ray_suelo.position.x = -8
	elif velocity.x > 0:
		sprite.flip_h = true
		area.scale.x = -1
		ray_suelo.position.x = 8

	move_and_slide()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file("res://dead.tscn")
