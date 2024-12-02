extends Node2D

func _ready() -> void:
	if Global.levels["level_2"]:
		$Button2.modulate = Color(0.41, 0.861, 0.456)
	else:
		$Button2.modulate = Color(0.912, 0.371, 0.375)
		
	if Global.levels["level_3"]:
		$Button3.modulate = Color(0.41, 0.861, 0.456)
	else:
		$Button3.modulate = Color(0.912, 0.371, 0.375)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_button_2_pressed() -> void:
	if Global.levels["level_2"]:
		get_tree().change_scene_to_file("res://levels/level_2.tscn")
