extends Node2D

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_setting_button_pressed():
	get_tree().change_scene_to_file("res://settings/settings.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
	
@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
