extends Node2D

signal gold_changed(int)

## UI
# INFO
@onready var gold_label: Label = $LevelCanvas/UI/GoldLabel
# Buttons
@onready var pawn_btn : Button = $LevelCanvas/UI/Container/PawnBtn

# Units
@onready var SoldiersContainer :  Node2D = $World/Soldiers/UnitsContainer
@onready var pawn_scn : PackedScene = preload("res://Scenes/Actors/Soldiers/pawn.tscn")

###### ACCESSOR ######

@export var gold: int = 0 : set = set_gold, get = get_gold
func set_gold(value: int) -> void:
	if gold != value:
		gold = value
		emit_signal("gold_changed", value)

func get_gold() -> int:
	return gold

######## BUILT-IN ########
# Called when the node enters the scene tree for the first time.
func _ready():
	pawn_btn.connect("pressed", _on_pawn_btn_pressed)
	self.connect("gold_changed", _on_gold_changed)

func _process(_delta: float) -> void:
	
	pawn_btn.disabled = get_gold() < 10
	
	
######## LOGIC #######

#GOLD
func add_gold(value: int) -> void:
	var new_gold = get_gold() + value
	set_gold(new_gold)

func remove_gold(value: int) -> void:
	var new_gold = max(get_gold() - value, 0)
	set_gold(new_gold)
	
#UNITS
func spawn_pawn()-> void:
	var pawn = pawn_scn.instantiate()
	SoldiersContainer.add_child(pawn)
	pawn.global_position = SoldiersContainer.global_position
	

######## EMITS #######

func _on_pawn_btn_pressed() -> void:
	remove_gold(10)
	spawn_pawn()

func _on_gold_changed(value: int) -> void:
	gold_label.set_text(str(value))
