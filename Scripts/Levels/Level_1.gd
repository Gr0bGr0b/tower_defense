extends Node2D

# Buttons
@onready var pawn_btn : Button = $LevelCanvas/UI/PawnBtn

# Units
@onready var SoldiersContainer :  Node2D = $World/Soldiers/UnitsContainer
@onready var pawn_scn : PackedScene = preload("res://Scenes/Actors/Soldiers/pawn.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pawn_btn.connect("pressed", _on_pawn_btn_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
######## LOGIC #######

func spawn_pawn()-> void:
	var pawn = pawn_scn.instantiate()
	SoldiersContainer.add_child(pawn)
	pawn.global_position = SoldiersContainer.global_position
	


######## EMITS #######

func _on_pawn_btn_pressed() -> void:
	spawn_pawn()
