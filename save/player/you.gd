extends CharacterBody2D

func _ready() -> void:
	Global.connect("health_changed", Callable(self, "_on_health_changed"))
	$AnimationPlayer.play("Camera")

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var player_position
var flip = null
var death = false
var attack = false
var attack_2 = false
var fly = false
var second_jump = true
var damage_taken = false

func _on_health_changed(new_hp):
	if new_hp < 0:
		Global.hp = 0
		death = true
		animation.play("death")
		restart.start()
	if new_hp > Global.max_hp:
		Global.hp = Global.max_hp
	if not death and new_hp < Global.max_hp and damage_taken:
		animation.play("hit")
		await animation.animation_finished
		damage_taken = false

@onready var animation = $AnimatedSprite2D
@onready var restart = $Restart

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		if Global.double_jump and second_jump and not death:
			if Input.is_action_just_pressed("ui_up"):
				if not attack and not attack_2 and not damage_taken:
					animation.play("jump")
				velocity.y = JUMP_VELOCITY
				second_jump = false
				
	if is_on_floor():
		second_jump = true
		
	if not death:
		if Input.is_action_just_pressed("ui_up") and is_on_floor() or Input.is_action_just_pressed("ui_up") and fly:
			if not attack and not attack_2 and not damage_taken:
				animation.play("jump")
			velocity.y = JUMP_VELOCITY
		
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			if velocity.y == 0 and not attack and not attack_2 and not damage_taken:
				animation.play("walk") 
		else:
			if velocity.y == 0 and not attack and not attack_2 and not damage_taken:
				animation.play("idle") 
			velocity.x = move_toward(velocity.x, 0, SPEED)

		if direction == -1 and not attack and not attack_2:
			flip = true
			Signals.emit_signal("player_flip", flip)
			animation.flip_h = true
			$"Attack/CollisionShape2D".position.x = -10
		
		if direction == 1 and not attack and not attack_2:
			flip = false
			Signals.emit_signal("player_flip", flip)
			animation.flip_h = false
			$"Attack/CollisionShape2D".position.x = 10
		
		if velocity.y > 0 and not attack and not attack_2 and not damage_taken:
			animation.play("jump")
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	player_position = self.position
	Signals.emit_signal("player_position_update", player_position)
	
	if Input.is_action_just_pressed("ui_attack") and not death and not attack_2 and not attack:
		$Attack/CollisionShape2D.disabled = false
		attack = true
		animation.play("attack")
		await animation.animation_finished
		$Attack/CollisionShape2D.disabled = true
		attack = false
		
	if Input.is_action_just_pressed("ui_attack_2") and not death and not attack_2 and not attack and Global.arrows != 0:
		attack_2 = true
		animation.play("attack_2")
		await animation.animation_finished
		var at_2 = preload("res://player/arrow.tscn")
		if not death:
			Global.arrows -= 1
			var arr = at_2.instantiate()
			$"../..".add_child(arr)
			arr.position = position
			attack_2 = false
			
	if Input.is_action_just_pressed("ui_heal") and not death and Global.hp_potion != 0:
		Global.hp_potion -= 1
		Global.hp += 50
		
func _on_restart_timeout() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_attack_body_entered(body: Node2D) -> void:
	body.hp -= Global.damage.pick_random()
