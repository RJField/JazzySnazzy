class_name PursuitBehavior extends EnemyBehavior

func create_state() -> BehaviorState:
    var new_state = PursuitState.new()
    new_state.state_creator = self
    return new_state