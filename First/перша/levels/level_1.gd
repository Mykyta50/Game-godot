extends Node2D

func _ready() -> void:
	var mobs = [$Mobs/Orc, $Mobs/Orc2]
	
@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.name == "You" or body.name in bodys:
		body.hp -= 1000

func change_scene():
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

var bodys = ["Orc", "Orc2", "Orc3"]

func _on_bot_jump_body_entered(body: Node2D) -> void:
	if body.name in bodys and body.chase:
		body.velocity.y = body.jump
