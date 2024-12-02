extends Node2D

var random_drop

func _on_child_exiting_tree(node: Node) -> void:
	random_drop = randi_range(0, 100)
	if random_drop < 91:
		var death_position = node.global_position
		var coin_3 = preload("res://coins/rubin_coin.tscn")
		var rubin_coin = coin_3.instantiate()
		call_deferred("rubin", rubin_coin, death_position)
	elif random_drop > 90 and random_drop < 101:
		var death_position = node.global_position
		var coin_4 = preload("res://coins/brilliant.tscn")
		var brilliant = coin_4.instantiate()
		call_deferred("brill", brilliant, death_position)

func rubin(rubin_coin: Node, death_position: Vector2) -> void:
	$"../Coins".add_child(rubin_coin)
	rubin_coin.position = death_position
	
func brill(brilliant: Node, death_position: Vector2) -> void:
	$"../Coins".add_child(brilliant)
	brilliant.position = death_position
