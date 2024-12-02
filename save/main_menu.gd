extends Node2D

var save_levels = "user://levels.dat"

func _ready() -> void:
	if FileAccess.file_exists(save_levels):
		var file = FileAccess.open(save_levels, FileAccess.READ)
		Global.levels = file.get_var()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://levels/levels.tscn")

func _on_setting_button_pressed():
	get_tree().change_scene_to_file("res://settings/settings.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
	
@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
