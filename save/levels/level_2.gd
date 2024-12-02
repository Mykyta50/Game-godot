extends Node2D

var save = "user://savefile.dat"

func _ready() -> void:
	var file = FileAccess.open(save, FileAccess.READ)
	Global.hp = file.get_var()
	Global.max_hp = file.get_var()
	Global.arrows = file.get_var()
	Global.coins = file.get_var()
	Global.double_jump = file.get_var()
	Global.hp_potion = file.get_var()
