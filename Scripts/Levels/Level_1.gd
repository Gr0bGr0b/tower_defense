extends Node2D

## UI
# INFO
@onready var gold_label: Label = $LevelCanvas/UI/GoldLabel
# Buttons
@onready var pawn_btn : Button = $LevelCanvas/UI/Container/PawnBtn

# Units
@onready var SoldiersContainer :  Node2D = $World/Soldiers/UnitsContainer
@onready var pawn_scn : PackedScene = preload("res://Scenes/Actors/Soldiers/pawn.tscn")

#Timer
@onready var pawn_btn_timer : Timer = $LevelCanvas/UI/Container/PawnBtnTimer

######## BUILT-IN ########
# Called when the node enters the scene tree for the first time.
func _ready():
	pawn_btn.connect("pressed", _on_pawn_btn_pressed)
	pawn_btn_timer.connect("timeout", _on_pawn_btn_timer_timeout)
	GAME_MANAGER.connect("gold_changed", _on_gold_changed)

	GAME_MANAGER.set_gold(30)
	
func _process(_delta: float) -> void:
	
	if pawn_btn_timer.is_stopped():
		pawn_btn.disabled = GAME_MANAGER.get_gold() < 10
	
	
######## LOGIC #######


#UNITS
func spawn_pawn()-> void:
	var pawn = pawn_scn.instantiate()
	SoldiersContainer.add_child(pawn)
	pawn.global_position = SoldiersContainer.global_position
	

######## EMITS #######

func _on_pawn_btn_pressed() -> void:
	pawn_btn.set_disabled(true)
	pawn_btn_timer.start()
	GAME_MANAGER.remove_gold(10)
	spawn_pawn()

func _on_gold_changed(value: int) -> void:
	gold_label.set_text(str(value))

func _on_pawn_btn_timer_timeout() -> void:
	pass
	pawn_btn.disabled = GAME_MANAGER.get_gold() < 10
