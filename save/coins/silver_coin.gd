extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	Global.coins += 1
	queue_free()
