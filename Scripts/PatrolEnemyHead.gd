extends CharacterBody2D

const enemyrun = 120
const gravedad = 98

# Variable para controlar si el enemigo está atacando
var atacando: bool = false

@onready var area: Area2D = $Area2D
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var ray_suelo: RayCast2D = $Floor

func _ready():
	velocity.x = -enemyrun
	sprite.play("Run")
	sprite.animation_finished.connect(_on_animation_finished)

func _physics_process(_delta):
	velocity.y += gravedad

	if not atacando:
		if is_on_wall() or !ray_suelo.is_colliding():
			velocity.x *= -1

		if velocity.x < 0:
			sprite.flip_h = false
			area.scale.x = 1
			ray_suelo.position.x = -8
		elif velocity.x > 0:
			sprite.flip_h = true
			area.scale.x = -1
			ray_suelo.position.x = 8
			
		sprite.play("Run")
	else:
		velocity.x = 0

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not atacando:
		atacar(body)

func atacar(target):
	atacando = true
	sprite.play("Attack")
	
	if target.has_method("take_damage"):
		target.take_damage(0.5)

func _on_animation_finished():
	if sprite.animation == "Attack":
		atacando = false
		velocity.x = enemyrun if sprite.flip_h else -enemyrun
		sprite.play("Run")
