extends Node2D

## UI
# INFO
@onready var gold_label: Label = $LevelCanvas/UI/GoldLabel
# Buttons
@onready var pawn_btn : Button = $LevelCanvas/UI/Container/PawnBtn
@onready var warrior_btn : Button = $LevelCanvas/UI/Container/WarriorBtn
# Units
@onready var SoldiersContainer :  Node2D = $World/Soldiers/UnitsContainer
@onready var pawn_scn : PackedScene = preload("res://Scenes/Actors/Soldiers/pawn.tscn")
@onready var warrior_scn : PackedScene = preload("res://Scenes/Actors/Soldiers/warrior.tscn")
#Timer
@onready var pawn_btn_timer : Timer = $LevelCanvas/UI/Container/PawnBtnTimer
@onready var warrior_btn_timer : Timer = $LevelCanvas/UI/Container/WarriorBtnTimer

######## BUILT-IN ########
# Called when the node enters the scene tree for the first time.
func _ready():
	pawn_btn.connect("pressed", _on_pawn_btn_pressed)
	pawn_btn_timer.connect("timeout", _on_pawn_btn_timer_timeout)
	warrior_btn.connect("pressed", _on_warrior_btn_pressed)
	warrior_btn_timer.connect("timeout", _on_warrior_btn_timer_timeout)
	GAME_MANAGER.connect("gold_changed", _on_gold_changed)
	

	GAME_MANAGER.set_gold(30)
	
func _process(_delta: float) -> void:
	
	if pawn_btn_timer.is_stopped():
		pawn_btn.disabled = GAME_MANAGER.get_gold() < 10
	
	if warrior_btn_timer.is_stopped():
		warrior_btn.disabled = GAME_MANAGER.get_gold() < 20
	
######## LOGIC #######


#UNITS
func spawn_pawn()-> void:
	var pawn = pawn_scn.instantiate()
	SoldiersContainer.add_child(pawn)
	pawn.global_position = SoldiersContainer.global_position
	
func spawn_warrior() -> void:
	var warrior = warrior_scn.instantiate()
	SoldiersContainer.add_child(warrior)
	warrior.global_position = SoldiersContainer.global_position

######## EMITS #######

func _on_pawn_btn_pressed() -> void:
	pawn_btn.set_disabled(true)
	pawn_btn_timer.start()
	GAME_MANAGER.remove_gold(10)
	spawn_pawn()
	
func _on_warrior_btn_pressed() -> void:
	warrior_btn.set_disabled(true)
	warrior_btn_timer.start()
	GAME_MANAGER.remove_gold(20)
	spawn_warrior()

func _on_gold_changed(value: int) -> void:
	gold_label.set_text(str(value))

func _on_pawn_btn_timer_timeout() -> void:
	pawn_btn.disabled = GAME_MANAGER.get_gold() < 10

func _on_warrior_btn_timer_timeout() -> void:
	warrior_btn.disabled = GAME_MANAGER.get_gold() < 20
