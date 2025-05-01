extends Node2D

# Buttons
@onready var pawn_btn : Button = $LevelCanvas/UI/PawnBtn

# Units
@onready var BlueUnitsContainer :  Node2D = $World/BlueUnitsContainer
@onready var pawn_scn : PackedScene = preload("res://Scenes/blue_pawn.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pawn_btn.connect("pressed", _on_pawn_btn_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
######## LOGIC #######

func spawn_pawn()-> void:
	var pawn = pawn_scn.instantiate()
	BlueUnitsContainer.add_child(pawn)
	pawn.global_position = BlueUnitsContainer.global_position
	


######## EMITS #######

func _on_pawn_btn_pressed() -> void:
	spawn_pawn()
