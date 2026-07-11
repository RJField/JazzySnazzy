class_name Encounter extends Node

signal encounter_complete 

@onready var room_state: RoomState = $"../RoomState"
var spawners: Array
var spawned_enemies: Array
var done_spawning: bool


@export var enemy_count_to_spawn: int = 2

func _ready() -> void:
    room_state.state_changed.connect(_on_state_changed)
    encounter_complete.connect(room_state.mark_cleared)
    spawners = fill_spawners()

func fill_spawners() -> Array:
    var room = get_parent()
    return get_tree().get_nodes_in_group("spawners").filter(
        func(s): return room.is_ancestor_of(s)
    )

func choose_spawner() -> Spawner:
        if spawners.is_empty():
            return null 
        var chosen: Spawner = spawners.pick_random()
        return chosen

func begin() -> void:
    done_spawning = false
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
        print("Total enemies spawned: ", spawned_enemies.size())
    done_spawning = true
    _check_cleared()

func _on_enemy_died(enemy) -> void:
    print("died: ", enemy)
    spawned_enemies.erase(enemy)
    _check_cleared()

func _on_state_changed(old_state, new_state):
    if new_state == RoomState.State.ATTENDING and old_state == RoomState.State.UNATTENDED:
        begin()

func _check_cleared() -> void:
    if done_spawning and spawned_enemies.is_empty():
        encounter_complete.emit()