extends CharacterBody2D

@export var max_health: float = 35
var health: float = max_health

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animated_sprite = $AnimatedSprite2D
@onready var progress_bar = $UI/ProgressBar
@onready var hit_sound = $HitSound

var direction: Vector2

func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
	set_physics_process(true)

func _process(_delta):
	if player:
		direction = player.global_position - global_position
		animated_sprite.flip_h = direction.x < 0

func _physics_process(_delta):
	if player:
		velocity = direction.normalized() * 80
		move_and_slide()

func take_damage(amount := 2.0):
	health -= amount
	print("Vida del boss:", health, "/", max_health)

	if progress_bar:
		progress_bar.value = health

	if hit_sound:
		hit_sound.play()

	var tween = create_tween()
	tween.tween_property(animated_sprite, "modulate", Color.RED, 0.1)
	tween.tween_property(animated_sprite, "modulate", Color.WHITE, 0.1)

	if health <= 0:
		GameManager.boss_died()   # ← CORRECCIÓN IMPORTANTE
		if progress_bar:
			progress_bar.visible = false
		queue_free()

func _on_damage_player_area_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(0.5)
