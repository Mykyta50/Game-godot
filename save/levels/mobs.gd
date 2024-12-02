extends Node2D

var random_drop

func _on_child_exiting_tree(node: Node) -> void:
	random_drop = randi_range(0, 100)
	if random_drop < 51:
		var death_position = node.global_position
		var coin_1 = preload("res://coins/silver_coin.tscn")
		var silver_coin = coin_1.instantiate()
		call_deferred("silver", silver_coin, death_position)
	elif random_drop > 50 and random_drop < 76:
		var death_position = node.global_position
		var coin_2 = preload("res://coins/gold_coin.tscn")
		var golden_coin = coin_2.instantiate()
		call_deferred("golden", golden_coin, death_position)
	elif random_drop > 75 and random_drop < 86:
		var death_position = node.global_position
		var coin_3 = preload("res://coins/rubin_coin.tscn")
		var rubin_coin = coin_3.instantiate()
		call_deferred("rubin", rubin_coin, death_position)
	elif random_drop == 99:
		var death_position = node.global_position
		var coin_4 = preload("res://coins/brilliant.tscn")
		var brilliant = coin_4.instantiate()
		call_deferred("brill", brilliant, death_position)
	#var orc = preload("res://orc/orc.tscn")
	#var orc1 = orc.instantiate()
	#call_deferred("spawn", orc1)

func silver(silver_coin: Node, death_position: Vector2) -> void:
	$"../Coins".add_child(silver_coin)
	silver_coin.position = death_position
	
func golden(golden_coin: Node, death_position: Vector2) -> void:
	$"../Coins".add_child(golden_coin)
	golden_coin.position = death_position
	
func rubin(rubin_coin: Node, death_position: Vector2) -> void:
	$"../Coins".add_child(rubin_coin)
	rubin_coin.position = death_position
	
func brill(brilliant: Node, death_position: Vector2) -> void:
	$"../Coins".add_child(brilliant)
	brilliant.position = death_position

#func  _process(delta: float) -> void:
	#var orc = preload("res://orc/orc.tscn")
	#var orc1 = orc.instantiate()
	#call_deferred("spawn", orc1)
#
func spawn(orc1: Node):
	add_child(orc1)
	orc1.position = Vector2(800, 950)
