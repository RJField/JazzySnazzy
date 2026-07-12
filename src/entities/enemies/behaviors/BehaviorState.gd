class_name BehaviorState extends RefCounted

var state_creator: EnemyBehavior

func tick(actor, target, delta) -> Vector2:
    push_error("No tick defined for this class")
    return Vector2.ZERO
