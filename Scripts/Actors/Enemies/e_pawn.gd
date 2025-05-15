extends Actor

@export var gold_reward : int = 15

func _ready() -> void:
	super()
	add_to_group("Enemies")
	set_direction(Vector2.LEFT)
	self.died.connect(_on_died)
	
######## EMITS ########

func _on_atk_area_entered(node: Node2D) -> void:
	if node.is_in_group("Soldiers"):
		set_target(node)
		state_machine.change_state(state_machine.states.Attack)

func _on_atk_area_exited(node: Node2D) -> void:
	set_target(null)
	state_machine.change_state(state_machine.states.Move)

func _on_died() -> void:
	GAME_MANAGER.add_gold(gold_reward)
