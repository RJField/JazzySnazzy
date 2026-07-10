extends Node2D

@onready var floor_area: Area2D = $Floor
@onready var room_state: RoomState = $RoomState

func _ready() -> void:
    floor_area.body_entered.connect(_on_body_entered)
    floor_area.body_exited.connect(_on_body_exited)
    room_state.state_changed.connect(_on_state_changed)

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