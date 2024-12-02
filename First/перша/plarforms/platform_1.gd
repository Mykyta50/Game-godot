extends CharacterBody2D

var first_position : Vector2 

func _ready():
	first_position = position
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + Vector2(750, 0), 3.0).set_trans(Tween.TRANS_SINE)
	tween.connect("finished", Callable(self, "_on_tween_completed")) 

func _on_tween_completed():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", first_position, 3.0).set_trans(Tween.TRANS_SINE)
	tween.connect("finished", Callable(self, "_on_tween_completed_2"))
	
func _on_tween_completed_2():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + Vector2(750, 0), 3.0).set_trans(Tween.TRANS_SINE)
	tween.connect("finished", Callable(self, "_on_tween_completed"))
