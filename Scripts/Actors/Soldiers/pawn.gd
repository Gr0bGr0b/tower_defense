extends Actor
class_name PawnSoldier

func _ready():
	super()
	add_to_group("Soldiers")
	set_direction(Vector2.RIGHT)
	
######## BUILT-IN ########

######## EMITS ########

func _on_atk_area_entered(node: Node2D) -> void:
	if node.is_in_group("Enemies"):
		set_target(node)
		state_machine.change_state(state_machine.states.Attack)

func _on_atk_area_exited(node: Node2D) -> void:
	set_target(null)
	state_machine.change_state(state_machine.states.Move)
