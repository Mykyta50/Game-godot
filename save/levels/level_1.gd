extends Node2D

var save = "user://savefile.dat"
var save_levels = "user://levels.dat"

func _ready() -> void:
	Global.levels["level_2"] = false
	Global.levels["level_3"] = false
	Global.arrows = 5
	Global.hp = 100
	Global.coins = 0
	Global.hp_potion = 2
	Global.max_hp = 100
	save_level()

func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.name != "You":
		body.hp -= 1000
	else:
		Global.hp -= 1000


func _on_jump_blocking_body_entered(body: Node2D) -> void:
	body.jump_2 = false
	body.jump_blocking = true

func _on_jump_blocking_body_exited(body: Node2D) -> void:
	body.jump_blocking = false

var exit

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	exit = true

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	exit = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_e") and exit:
		Global.levels["level_2"] = true
		save_game()
		save_level()
		get_tree().change_scene_to_file("res://levels/level_2.tscn")
		
func save_game():
	var file = FileAccess.open(save, FileAccess.WRITE)
	file.store_var(Global.hp)
	file.store_var(Global.max_hp)
	file.store_var(Global.arrows)
	file.store_var(Global.coins)
	file.store_var(Global.double_jump)
	file.store_var(Global.hp_potion)
	
func save_level():
	var file = FileAccess.open(save_levels, FileAccess.WRITE)
	file.store_var(Global.levels)
