extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	Global.coins += 50
	queue_free()
