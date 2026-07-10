class_name Encounter extends Node

#signal room_cleared 

@onready var room_state: RoomState = $"../RoomState"
var spawners: Array
var spawned_enemies: Array


@export var enemy_count_to_spawn: int = 2

func _ready() -> void:
    room_state.state_changed.connect(_on_state_changed)
    spawners = fill_spawners()

func fill_spawners() -> Array:
    print(get_tree().get_nodes_in_group("spawners"))
    return get_tree().get_nodes_in_group("spawners")

func choose_spawner() -> Spawner:
        if spawners.is_empty():
            return null 
        var chosen: Spawner = spawners.pick_random()
        return chosen

func begin() -> void:
    while enemy_count_to_spawn > 0:
        #added a one second delay to ensure no collision on spawn preventing spawn -> but we need to revisit this
        await get_tree().create_timer(1.0).timeout
        var chosen := choose_spawner()
        print("chosen: ", chosen, " remaining: ", enemy_count_to_spawn)
        if chosen == null:
            return
        var enemy = chosen.spawn()
        enemy.death_event.connect(_on_enemy_died.bind(enemy))
        spawned_enemies.append(enemy)
        enemy_count_to_spawn -= 1
        print(spawned_enemies.size())

func _on_enemy_died(enemy) -> void:
    print("died: ", enemy)
    spawned_enemies.erase(enemy)

func _on_state_changed(old_state, new_state):
    if new_state == RoomState.State.ATTENDING and old_state == RoomState.State.UNATTENDED:
        begin()
