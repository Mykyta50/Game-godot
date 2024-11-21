extends CharacterBody2D

func _ready() -> void:
	$Label.text = str(hp)
	
var chase = false
var speed = 130
var jump = -400.0
var death = false
var attack = false
var damage = randi_range(20, 25)
var hp = 100:
	set(value):
		hp = value
		if hp <= 0:
			hp = 0
			$Label.text = str(hp)
			death = true
			animation.play("death")
			await animation.animation_finished 
			queue_free()
			var death_position = position
		$Label.text = str(hp)

@onready var animation = $AnimatedSprite2D
@onready var hit_timer = $Hit_timer
@onready var hit_timer2 = $Hit_timer2

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not death and not attack:
		var player = $"../../Player/You"
		var direction = (player.position - self.position).normalized() 
		if chase:
			velocity.x = direction.x * speed
			animation.play("chase")
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			animation.play("idle")

		if direction.x < 0:
			animation.flip_h = true
		else:
			animation.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "You":
		chase = true

func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "You":
		chase = false

func _on_death_body_entered(body: Node2D) -> void:
	var player = $"../../Player/You"
	if body.name == "You" and not body.death:
		body.damage_taken = true
		player.velocity.y = player.JUMP_VELOCITY
		player.hp -= damage
		
func _on_attack_body_entered(body: Node2D) -> void:
	@warning_ignore("unused_variable")
	var player = $"../../Player/You"
	if body.name == "You" and not death and not body.death:
		hit_timer.start()
		hit_timer2.start()
		attack = true
		animation.play("attack")
		await animation.animation_finished
		$Attack/CollisionShape2D.disabled = false
		attack = false

func _on_hit_timer_timeout():
	$Attack/CollisionShape2D.disabled = true
	$Hit/CollisionShape2D.disabled = false
	
func _on_hit_timer_2_timeout():
	$Hit/CollisionShape2D.disabled = true

func _on_hit_body_entered(body: Node2D) -> void:
	@warning_ignore("unused_variable")
	var player = $"../../Player/You"
	if body.name == "You" and not death:
		body.damage_taken = true
		body.hp -= damage
