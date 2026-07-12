extends Node


const ROOM_SPACING = 1400
@export var room_scene: PackedScene
@export var room_count: int = 2

@onready var player: CharacterBody2D = $Player

var all_rooms: Array = []
var current_room: Room

func _ready() -> void:
    instantiate_rooms()
    set_door_taget()
    activate(all_rooms[0], Vector2.ZERO)
    return


func activate(target, entry):
    player.global_position = entry
    for r in all_rooms:
        if r == target:
            #set live
            r.process_mode = Node.PROCESS_MODE_INHERIT
            r.visible = true
            current_room = r
            print(current_room)
        else:
            #set dormant
            r.process_mode = Node.PROCESS_MODE_DISABLED
            r.visible = false

func instantiate_rooms():
    for i in room_count:
        var r = room_scene.instantiate()
        add_child(r)
        r.position = Vector2(i * ROOM_SPACING, 0)
        r.set_player(player)
        #r.get_node("Encounter").enemy_count_to_spawn *= i #added this to add some difficulty increase
        all_rooms.append(r)
        r.room_complete.connect(_on_room_complete)

func _on_room_complete() -> void:
    var next = get_next_room()
    if next:
        print("room completed!")

func get_next_room() -> Room:
    var room_index = all_rooms.find(current_room) + 1
    if room_index >= all_rooms.size():
        return null
    return all_rooms[room_index]
    
func set_door_taget():
    print("set_door_target called for count of rooms: ", all_rooms.size())
    for i in all_rooms.size():
        if i + 1 >= all_rooms.size():
            continue
        for door in all_rooms[i].get_doors():
            door.target = all_rooms[i + 1]
            door.transition_requested.connect(_on_transition_requested)

func _on_transition_requested(target):
    activate(target, target.position)
    print("moving to next level")