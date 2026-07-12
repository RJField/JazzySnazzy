class_name Spawner extends Marker2D

@export var spawn_pool: Array[EnemyData]
@export var container: Node2D

func _ready() -> void:
    add_to_group("spawners")


func _spawn_pool_picker(pool: Array[EnemyData]) -> EnemyData:
    if pool.is_empty():
        return null
    return pool.pick_random()


func spawn(body: CharacterBody2D) -> Node:
        if container == null:
            push_error("Container null")
            return null
        var chosen := _spawn_pool_picker(spawn_pool)
        if chosen == null:
            push_error("Chosen null")
            return null
        if chosen.scene == null:
            push_error("Chosen null")
            return null
        var enemy = chosen.scene.instantiate()
        container.add_child(enemy)
        print("for spawner, player is", body)
        enemy.configure(chosen, body)
        enemy.global_position = global_position
        return enemy
