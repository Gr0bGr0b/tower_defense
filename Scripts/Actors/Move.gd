extends BaseState


func physics_process(delta) -> Node2D:
	var dir = actor.get_direction()
	actor.position.x += actor.speed * delta
	return self
