extends Node

signal gold_changed(int)

var gold: int = 0 : set = set_gold, get = get_gold

func set_gold(value: int) -> void:
	if gold != value:
		gold = value
		emit_signal("gold_changed", value)

func get_gold() -> int:
	return gold


######## LOGIC ####@@@#

#GOLD
func add_gold(value: int) -> void:
	var new_gold = get_gold() + value
	set_gold(new_gold)

func remove_gold(value: int) -> void:
	var new_gold = max(get_gold() - value, 0)
	set_gold(new_gold)
	
