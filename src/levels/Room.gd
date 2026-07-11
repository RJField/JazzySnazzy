class_name Room extends Node2D

signal room_complete

@onready var floor_area: Area2D = $Floor
@onready var room_state: RoomState = $RoomState
@onready var encounter: Encounter = $Encounter

func _ready() -> void:
    room_state.state_changed.connect(_on_state_changed)
    encounter.encounter_complete.connect(_on_encounter_complete)
    
    #added await for first physics frame to avoid immediate state change on run (i.e. we want the placement as part of world to set this, not the initial overlap)
    await get_tree().physics_frame
    
    floor_area.body_entered.connect(_on_body_entered)
    floor_area.body_exited.connect(_on_body_exited)
    for door in get_doors():
        room_complete.connect(door.unlock)

func _on_body_entered(body: Node):
    if not body.is_in_group("player"):
        return
    room_state.enter()

func _on_body_exited(body: Node):
    if not body.is_in_group("player"):
        return
    room_state.exit()

func _on_state_changed(old_state, new_state) -> void:
    print("%s: %s -> %s" % [name,RoomState.State.keys()[old_state], RoomState.State.keys()[new_state]])

func _on_encounter_complete() -> void:
        room_complete.emit()
        print("Room emitting room_complete")

func get_doors() -> Array:
    return get_tree().get_nodes_in_group("doors").filter(
        func(d): return is_ancestor_of(d))
    