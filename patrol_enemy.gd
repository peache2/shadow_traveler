extends CharacterBody2D

@export var player: CharacterBody2D
@export var SPEED: int = 60
@export var CHASE_SPEED: int = 170
@export var ACCELERATION: int = 300


@onready var sprite: AnimatedSprite2D = $Sprite
@onready var ray_cast: RayCast2D = $Sprite/RayCast2D
@onready var timer = $Timer

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.RIGHT

enum States {
	WANDER,
	CHASE
}

var current_state = States.WANDER

func _ready():
	sprite.flip_h = true
	ray_cast.target_position = Vector2(125, 0)
	ray_cast.enabled = true

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement(delta)
	change_direction()
	look_for_player()

func look_for_player():
	ray_cast.force_raycast_update()

	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider == player:
			chase_player()
		elif current_state == States.CHASE:
			stop_chase()
	elif current_state == States.CHASE:
		stop_chase()

func chase_player() -> void:
	timer.stop()
	current_state = States.CHASE

func stop_chase() -> void:
	if timer.time_left <= 0:
		timer.start()

func handle_movement(delta: float) -> void:
	var target_speed = SPEED if current_state == States.WANDER else CHASE_SPEED
	velocity = velocity.move_toward(direction * target_speed, ACCELERATION * delta)
	move_and_slide()

func flip_direction():
	direction.x *= -1
	sprite.flip_h = direction.x > 0
	ray_cast.target_position = Vector2(125 * direction.x, 0)
	ray_cast.force_raycast_update()

func change_direction() -> void:
	if current_state == States.WANDER:
		if is_on_wall():
			flip_direction()
	else:
		var dx = player.position.x - position.x
		direction.x = sign(dx)

		if direction.x != 0:
			sprite.flip_h = direction.x > 0
			ray_cast.target_position = Vector2(125 * direction.x, 0)
			ray_cast.force_raycast_update()

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_timer_timeout():
	current_state = States.WANDER

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "player":
		$Sprite.play("attack")

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "player":
		$Sprite.play("walk")
