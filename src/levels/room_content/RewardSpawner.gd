class_name RewardSpawner extends Marker2D

@export var reward_pool : Array = []
@export var container : Node2D

func _ready() -> void:
    add_to_group("rewardspawners")
    return

#took this from the enemy spawner -> will need to check on the pick random function
func _spawn_pool_picker(pool: Array):
    if pool.is_empty():
        return
    return pool.pick_random()
    
#doesnt pass anything into spawn() (different from enemy spawner, which required a target)
func spawn() -> void:
    print("spawn was called for rewards")
    if container == null:
        push_error("Container null for spawner")
        return
    var chosen = _spawn_pool_picker(reward_pool)
    if chosen == null:
        push_error("chosen null for reward spawner")
        return
    if chosen.scene == null:
        push_error("Chosen scene null for reward spawner")
        return
    var reward = chosen.scene.instantiate()
    container.add_child(reward)
    reward.configure(chosen)
    reward.global_position = global_position
    print("reward position = ", reward.global_position)
    return