extends Area2D
class_name Tower

@onready var healthbar : TextureProgressBar = $Control/HealthBar
@export var health: int = 100

signal getting_hit

func _ready() -> void:
	self.getting_hit.connect(_on_getting_hit)

######## LOGIC ########

func hit(damage: int) -> void:
	health -= damage 
	emit_signal("getting_hit")
	if health <= 0:
		_destroy()

func _destroy() -> void:
	print('Tower destroyed')
	queue_free()
	
	
######## EMITS #######

func _on_getting_hit() -> void:
	healthbar.set_value(health)
