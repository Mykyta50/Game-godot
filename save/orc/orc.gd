extends CharacterBody2D

func _ready() -> void:
	Signals.connect("player_position_update", Callable(self, "_on_player_position_update"))
	$Label.text = str(hp)
	Signals.connect("player_flip", Callable(self, "_flip"))
	
var chase = false
var speed = 140
var jump = -450.0
var jump_2 = true
var death = false
var attack = false
var jump_blocking = false
var damage = [20, 21, 22, 23, 24, 25]
var hp = 100:
	set(value):
		hp = value
		var tween = get_tree().create_tween()
		tween.set_loops(4)
		tween.tween_property(animation, "modulate:a", 0, 0.05)
		tween.tween_property(animation, "modulate:a", 1, 0.05)
		if hp <= 0:
			hp = 0
			$Label.text = str(hp)
			death = true
			animation.play("death")
			collision_layer = 1 << 3
			collision_mask = 1 << 0
			$Death.collision_mask = 1 << 0
			$Foot.collision_mask = 1 << 0
			await animation.animation_finished 
			queue_free()
		$Label.text = str(hp)
		

@onready var animation = $AnimatedSprite2D
@onready var hit_timer = $Hit_timer
@onready var hit_timer2 = $Hit_timer2

var player

func _on_player_position_update(player_position):
	player = player_position

func _physics_process(delta: float) -> void:
	
	if hp != 100:
		chase = true
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		if jump_2 and not jump_blocking:
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
			
		if chase and is_on_wall() and is_on_floor(): 
			velocity.y = jump

		if direction.x < 0:
			animation.flip_h = true
		else:
			animation.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
func _on_detector_body_entered(_body: Node2D) -> void:
	chase = true

func _on_death_body_entered(body: Node2D) -> void:
	if not body.death:
		body.damage_taken = true
		body.velocity.y = body.JUMP_VELOCITY
		Global.hp -= damage.pick_random()
		
func _on_attack_body_entered(body: Node2D) -> void:
	if not death and not body.death:
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
	if not death:
		body.damage_taken = true
		Global.hp -= damage.pick_random()

func _on_foot_body_entered(body: Node2D) -> void:
	if body is not TileMapLayer:
		if not body.death:
			body.damage_taken = true
			velocity.y = jump
			Global.hp -= damage.pick_random()
