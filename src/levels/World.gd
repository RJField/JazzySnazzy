extends Node


@onready var room: Room = $Room

func _ready() -> void:
    room.room_state.enter()
    return