extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var death = false
var attack = false
var hit = false
var fly = false
var damage_taken = false
var damage = randi_range(20, 30)
var max_hp = 100
var hp = 100:
	set(value):
		hp = value
		if hp <= 0:
			hp = 0
			death = true
			animation.play("death")
			restart.start()
		if hp > max_hp:
			hp = max_hp
		if hp != 0 and hp < max_hp and damage_taken:
			animation.play("hit")
			hit = true
			await animation.animation_finished
			hit = false
			damage_taken = false
			
@onready var animation = $AnimatedSprite2D
@onready var restart = $Restart

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if not death:
		if Input.is_action_just_pressed("ui_up") and is_on_floor() or Input.is_action_just_pressed("ui_up") and fly:
			if not attack and not hit:
				animation.play("jump")
			velocity.y = JUMP_VELOCITY

		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			if velocity.y == 0 and not attack and not hit:
				animation.play("walk") 
		else:
			if velocity.y == 0 and not attack and not hit:
				animation.play("idle") 
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if Input.is_action_just_pressed("ui_dash"):
			direction = 100
	
		if direction == -1 and not attack:
			animation.flip_h = true
			$"Attack/CollisionShape2D".position.x = -10
		
		if direction == 1 and not attack:
			animation.flip_h = false
			$"Attack/CollisionShape2D".position.x = 10
		
		if velocity.y > 0 and not attack and not hit:
			animation.play("jump")
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_attack") and not death:
		$Attack/CollisionShape2D.disabled = false
		attack = true
		animation.play("attack")
		await animation.animation_finished
		$Attack/CollisionShape2D.disabled = true
		attack = false
		
func _on_restart_timeout() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")
	
var mobs = ["Orc", "Orc2", "Orc3"]

func _on_attack_body_entered(body: Node2D) -> void:
	if body.name in mobs:
		body.hp -= damage
