extends LineEdit

var open = true

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cheat"):
		placeholder_text = "Введіть:"
		text = ""
		visible = open
		open = not open
	if Input.is_action_just_pressed("ui_accept"):
		if text == "/god":
			if $"../../Player/You".max_hp < 1000:
				$"../../Player/You".max_hp += 9900
				$"../../Player/You".hp += 9900
				$"../../Player/You".damage = 100000
				$"../HP_2".visible = true
				$"../HP".visible = true
			placeholder_text = "Чіт-код введено"
		elif text == "/kill":
			$"../../Player/You".hp -= 99999999999999999
			placeholder_text = "Чіт-код введено"
		elif text == "/hardcore":
			$"../../Player/You".max_hp = 1
			$"../../Player/You".hp = 1
			$"../HP_2".visible = false
			$"../HP".visible = false
			placeholder_text = "Чіт-код введено"
		elif text == "/fly":
			$"../../Player/You".fly = true
			placeholder_text = "Чіт-код введено"
		elif text == "/q":
			get_tree().change_scene_to_file("res://main_menu.tscn")
			placeholder_text = "Чіт-код введено"
		elif text == "/hesoyam":
			$"../../Player/You".hp = $"../../Player/You".max_hp
			placeholder_text = "Чіт-код введено"
		else:
			placeholder_text = "Помилка, такого коду не існує."
		text = ""
		
