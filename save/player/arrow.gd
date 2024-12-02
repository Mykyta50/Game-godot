extends Area2D

var damage = [47, 48, 49, 50, 51, 52, 53, 54]

func _ready() -> void:
	if Global.pla_f:
		$Sprite2D.flip_h = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Global.pla_pos + Vector2(-1000, 0), 1.3)
		tween.tween_callback(queue_free)
	if not Global.pla_f:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Global.pla_pos + Vector2(1000, 0), 1.3)
		tween.tween_callback(queue_free)

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()
	elif body.collision_layer & (1 << 2) != 0:
		body.hp -= damage.pick_random()
		queue_free()
	else:
		queue_free()
