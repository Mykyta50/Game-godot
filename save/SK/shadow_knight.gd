extends CharacterBody2D

func _ready() -> void:
	Signals.connect("player_position_update", Callable(self, "_on_player_position_update"))
	$Label.text = str(hp)

var chase = false
var attack = false
var speed = 315
var jump = -450.0
var jump_2 = true
var jump_blocking = false
var damage = [37, 38, 39, 40, 41, 42]
var death = false
var hp = 300:
	set(value):
		hp = value
		if hp < 0:
			hp = 0
			$Label.text = str(hp)
			death = true
			animation.play("death")
			collision_layer = 1 << 3
			collision_mask = 1 << 0
			$Area2D.collision_mask = 1 << 0
			await animation.animation_finished
			queue_free()
		else:
			$Label.text = str(hp)
			var tween = get_tree().create_tween()
			tween.set_loops(4)
			tween.tween_property(animation, "modulate:a", 0, 0.05)
			tween.tween_property(animation, "modulate:a", 1, 0.05)
			
@onready var animation = $AnimatedSprite2D

var player

func _on_player_position_update(player_position):
	player = player_position

func _physics_process(delta: float) -> void:
	
	if hp != 300:
		chase = true
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		if jump_2:
			velocity.y = jump
			jump_2 = false
			
	if is_on_floor():
		jump_2 = true
		
	if not death and not attack:
		var direction = (player - self.position).normalized()
		if chase:
			velocity.x = direction.x * speed
			animation.play("chase")
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			animation.play("idle")
		
		if direction.x < 0:
			animation.flip_h = true
			$Hit/CollisionShape2D.position.x = -37
		else:
			animation.flip_h = false
			$Hit/CollisionShape2D.position.x = 37
			
		if chase and is_on_wall() and is_on_floor(): 
			velocity.y = jump
			
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
	
func _on_detector_body_entered(_body: Node2D) -> void:
	chase = true
		
func attacking():
	$Attack/CollisionShape2D.call_deferred("set_disabled", true)
	await get_tree().create_timer(0.28).timeout
	$Hit/CollisionShape2D.call_deferred("set_disabled", false)
	await get_tree().create_timer(0.2).timeout
	$Hit/CollisionShape2D.call_deferred("set_disabled", true)

func _on_attack_body_entered(body: Node2D) -> void:
	if not death and not body.death:
		attacking()
		animation.play("attack")
		attack = true
		await animation.animation_finished
		attack = false
		$Attack/CollisionShape2D.disabled = false

func _on_hit_body_entered(body: Node2D) -> void:
	if not death:
		body.damage_taken = true
		Global.hp -= damage.pick_random()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not death and not body.death:
		body.damage_taken = true
		Global.hp -= damage.pick_random()
		body.velocity.y = body.JUMP_VELOCITY
