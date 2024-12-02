extends Node2D

var shop
var shop_open
@onready var menu = $CanvasLayer
@onready var label = $CanvasLayer/Panel/Panel/Label

func _on_area_2d_body_entered(_body: Node2D) -> void:
	shop = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	shop = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_e") and shop:
		if not menu.visible:
			menu.visible = true
			get_tree().paused = true
			shop_open = true
			Signals.emit_signal("shop", shop_open)
		elif menu.visible:
			menu.visible = false
			get_tree().paused = false
			shop_open = false
			Signals.emit_signal("shop", shop_open)


func _on_texture_button_mouse_entered() -> void:
	label.text = "Стріли (х3) \n \n Ціна: 35"

func _on_texture_button_mouse_exited() -> void:
	label.text = ""

func _on_texture_button_pressed() -> void:
	if Global.coins >= 35:
		Global.coins -= 35
		Global.arrows += 3


func _on_texture_button_2_mouse_entered() -> void:
	label.text = "Лікувальне зілля \n \n Ціна: 50"

func _on_texture_button_2_mouse_exited() -> void:
	label.text = ""

func _on_texture_button_2_pressed() -> void:
	if Global.coins >= 50:
		Global.coins -= 50
		Global.hp_potion += 1


func _on_texture_button_3_mouse_entered() -> void:
	label.text = "Максимальне здоров'я + 25 \n \n Ціна: 90"

func _on_texture_button_3_mouse_exited() -> void:
	label.text = ""

func _on_texture_button_3_pressed() -> void:
	if Global.coins >= 90:
		Global.coins -= 90
		Global.max_hp += 25
		Global.hp += 25


func _on_texture_button_4_mouse_entered() -> void:
	label.text = "Подвійний стрибок \n \n Ціна: 175"

func _on_texture_button_4_mouse_exited() -> void:
	label.text = ""

func _on_texture_button_4_pressed() -> void:
	if Global.coins >= 175 and not Global.double_jump:
		Global.coins -= 175
		Global.double_jump = true
