extends CharacterBody2D

@export var max_health: float = 35
var health: float = max_health

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animated_sprite = $AnimatedSprite2D
@onready var health_control = $CanvasLayer/Control
@onready var hit_sound = $DamagePlayerArea/HitSound

var direction: Vector2

signal health_changed(value: float)

func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
	connect("health_changed", Callable(health_control, "set_health"))
	emit_signal("health_changed", health / max_health)

func _process(_delta):
	if player:
		direction = player.global_position - global_position
		animated_sprite.flip_h = direction.x < 0

func _physics_process(_delta):
	if player:
		velocity = direction.normalized() * 60
		move_and_slide()

func take_damage(amount: float):
	health -= amount
	print("Vida del boss:", health, "/", max_health)

	emit_signal("health_changed", health / max_health)

	if hit_sound:
		hit_sound.play()

	flash_red()

	if health <= 0:
		GameManager.boss_died() 
		queue_free()

func flash_red():
	animated_sprite.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.15).timeout
	animated_sprite.modulate = Color(1, 1, 1)

func _on_damage_player_area_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(0.5)
