extends Area2D
class_name Tower

@export var health: int = 100

######## LOGIC ########

func hit(damage: int) -> void:
	health -= damage 
	if health <= 0:
		_destroy()

func _destroy() -> void:
	print('Tower destroyed')
	queue_free()
