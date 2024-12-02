extends CharacterBody2D

var first_position : Vector2 
var fall
@onready var timer = $Timer
@onready var sprite = $Sprite2D

func _ready():
	first_position = sprite.position
	
func _on_fall_detector_body_entered(_body: Node2D) -> void:
	var tween = get_tree().create_tween()
	timer.start()
	tween.set_loops(4)
	tween.tween_property(sprite, "position", sprite.position + Vector2(4, 0), 0.07)
	tween.tween_property(sprite, "position", first_position, 0.07)


func _on_timer_timeout() -> void:
	fall = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + Vector2(0, 1000), 1.0)
	
#func _physics_process(delta: float) -> void:
	#if fall:
		#velocity += get_gravity() * delta
		#move_and_slide()
