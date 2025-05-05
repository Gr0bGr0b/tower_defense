extends Node2D

@onready var spawn_timer : Timer = $SpawnTimer
@onready var units_container: Node2D = $UnitsContainer
# UNITS
@export var units_scn: Array[PackedScene]


func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)


######## LOGIC #######

func spawn_unit(unit_scn: PackedScene) -> void:
	var unit = unit_scn.instantiate()
	units_container.add_child(unit)

######## EMITS ########
func _on_spawn_timer_timeout() -> void:
	print("Timeout")
	spawn_unit(units_scn.pick_random())
