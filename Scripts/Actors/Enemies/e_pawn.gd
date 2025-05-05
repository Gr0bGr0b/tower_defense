extends Actor

func _ready():
	super()
	add_to_group("Enemies")
	set_direction(Vector2.LEFT)
