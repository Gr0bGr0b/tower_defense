extends BaseState
class_name MoveState


func physics_process(delta) -> Node2D:
	var dir = actor.get_direction()
	actor.position.x += dir.x * actor.speed * delta
	return self
