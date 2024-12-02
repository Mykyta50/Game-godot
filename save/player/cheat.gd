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
			if Global.max_hp < 1000:
				Global.max_hp += 9900
				Global.hp += 9900
				Global.damage.damage = [100000]
				$"../HP_2".visible = true
				$"../HP".visible = true
			placeholder_text = "Чіт-код введено"
		elif text == "/kill":
			Global.hp -= 99999999999999999
			placeholder_text = "Чіт-код введено"
		elif text == "/hardcore":
			Global.max_hp = 1
			Global.hp = 1
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
			Global.hp = Global.max_hp
			Global.coins += 2500
			placeholder_text = "Чіт-код введено"
		elif text == "/kill en":
			for mob in $"../../Mobs".get_children():
				mob.hp -= 99999
			placeholder_text = "Чіт-код введено"
		elif text == "/arrows":
			Global.arrows += 100
			placeholder_text = "Чіт-код введено"
		elif text == "/hp":
			Global.hp_potion += 10
			placeholder_text = "Чіт-код введено"
		else:
			placeholder_text = "Помилка, такого коду не існує."
		text = ""
		
