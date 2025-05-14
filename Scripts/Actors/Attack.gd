extends BaseState
class_name AttackState

@export var hit_frame: int 

var can_attack : bool = false

func enter() -> void:
	super()

func process(delta: float) -> Node2D:
	if actor.sprite.get_frame() == hit_frame and can_attack:
		_attack()
	
	if actor.sprite.get_frame() != hit_frame:
		can_attack = true
		
	if actor.get_target() == null:
		return states.Move
	return self
	

######## LOGIC ########
func _attack() -> void:
	can_attack = false
	if actor.get_target() != null:
		actor.get_target().hit(actor.damage)
