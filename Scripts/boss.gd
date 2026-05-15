extends CharacterBody2D

var jugador_en_area: Node2D = null

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animated_sprite = $AnimatedSprite2D
@onready var progress_bar = $UI/ProgressBar

var direction : Vector2

var health: int = 10:
	set(value):
		health = value
		if progress_bar:
			progress_bar.value = value
		
		if health <= 0:
			if progress_bar:
				progress_bar.visible = false
			var fsm = find_child("FiniteStateMachine")
			if fsm:
				fsm.change_state("Death")
			else:
				queue_free() 
func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
	
	set_physics_process(false)

func _process(_delta):
	if player:
		direction = player.global_position - global_position
		animated_sprite.flip_h = direction.x < 0

func _physics_process(_delta):
	if player:
		velocity = direction.normalized() * 40
		move_and_slide()

func take_damage():
	health -= 2
	var tween = create_tween()
	tween.tween_property(animated_sprite, "modulate", Color.RED, 0.1)
	tween.tween_property(animated_sprite, "modulate", Color.WHITE, 0.1)

func _on_damage_player_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(0.5)
