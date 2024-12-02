extends Control

func _ready() -> void:
	Signals.connect("shop", Callable(self, "_on_shop_open"))

var check 

func _on_shop_open(shop_open):
	check = shop_open


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and not check:
		if not visible:
			visible = true
			get_tree().paused = true
		elif visible:
			visible = false
			get_tree().paused = false

func _on_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_button_3_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
	visible = false

func _on_button_2_pressed() -> void:
	pass
