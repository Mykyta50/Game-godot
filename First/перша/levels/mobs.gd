extends Node2D


func _ready() -> void:
	var mobs = preload("res://orc/orc.tscn")
	var Orc3 = mobs.instantiate()
	add_child(Orc3)
	Orc3.position = Vector2(850, 850)
	Orc3.name = "Orc3"
	
	var coin_1 = preload("res://coins/silver_coin.tscn")
	var silver_coin = coin_1.instantiate()
