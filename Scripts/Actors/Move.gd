extends BaseState
class_name MoveState


func physics_process(delta) -> Node2D:
	var dir = actor.get_direction()
	actor.velocity = dir * actor.speed
	actor.move_and_slide()
	return self
