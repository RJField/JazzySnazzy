extends Node


const ROOM_SPACING = 1400
@export var room_scene: PackedScene
@export var room_count: int = 2

@onready var player: CharacterBody2D = $Player

var all_rooms: Array = []

func _ready() -> void:
    instantiate_rooms()
    activate(all_rooms[0], Vector2.ZERO)
    return


func activate(target, entry):
    player.global_position = entry
    for r in all_rooms:
        if r == target:
            #set live
            r.process_mode = Node.PROCESS_MODE_INHERIT
            r.visible = true

        else:
            #set dormant
            r.process_mode = Node.PROCESS_MODE_DISABLED
            r.visible = false

func instantiate_rooms():
    for i in room_count:
        var r = room_scene.instantiate()
        add_child(r)
        r.position = Vector2(i * ROOM_SPACING, 0)
        all_rooms.append(r)

