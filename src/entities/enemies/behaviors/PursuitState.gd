class_name PursuitState extends BehaviorState


func tick(actor: Node2D, target: Node2D, delta) -> Vector2:
    if target:
        var direction = actor.global_position.direction_to(target.global_position)
        return direction
    return Vector2.ZERO

    
