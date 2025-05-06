extends BaseState
class_name AttackState

@export var wait_time : float = 1.0
@onready var attack_timer : Timer = Timer.new()

func _ready() -> void:
	super()
	add_child(attack_timer)
	attack_timer.set_wait_time(wait_time)
	attack_timer.timeout.connect(_on_attack_timer_timeout)

func enter() -> void:
	super()
	attack_timer.start()
	

######## LOGIC ########
func _attack() -> void:
	if actor.get_target() != null:
		actor.get_target().hit(actor.damage)


######## EMITS ########
func _on_attack_timer_timeout() -> void:
	_attack()
