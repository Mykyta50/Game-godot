extends Node

func _ready() -> void:
	Signals.connect("player_flip", Callable(self, "_flip"))
	Signals.connect("player_position_update", Callable(self, "_on_player_position_update"))

var pla_pos

func _on_player_position_update(player_position):
	pla_pos = player_position
	
var pla_f

func _flip(flip):
	pla_f = flip

signal health_changed(new_hp)

var hp = 100:
	set(value):
		hp = value
		emit_signal("health_changed", hp)

var max_hp = 100
var arrows = 5
var hp_potion = 2
var coins = 0
var double_jump = false
var damage = [20, 21, 22, 23, 24, 25]

var levels = {
	"level_1": true,
	"level_2": false,
	"level_3": false
}
