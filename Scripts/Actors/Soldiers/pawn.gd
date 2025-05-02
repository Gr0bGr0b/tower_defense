extends Actor
class_name PawnSoldier


@export var damage : int = 2

func _ready():
	super()
	add_to_group("Soldiers")
	set_direction(Vector2.RIGHT)
	
######## BUILT-IN ########

######## EMITS ########

func _on_area_entered(node: Area2D) -> void:
	if node.is_in_group("Enemies"):
		set_target(node)
		state_machine.change_state(state_machine.states.Attack)

func _on_area_exited() -> void:
	set_target(null)
