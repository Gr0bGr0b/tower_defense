extends Actor

func _ready():
	super()
	add_to_group("Enemies")
	set_direction(Vector2.LEFT)


######## EMITS ########

func _on_atk_area_entered(node) -> void:
	if node.is_in_group("Soldiers"):
		set_target(node)
		state_machine.change_state(state_machine.states.Attack)

func _on_atk_area_exited(node: Area2D) -> void:
	set_target(null)
	state_machine.change_state(state_machine.states.Move)
