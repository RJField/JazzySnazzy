extends Area2D

signal transition_requested(target: Room)

@export var target: Room

var locked: bool = true

func _ready():
    add_to_group("doors")
    body_entered.connect(_on_body_entered)

func unlock() -> void:
    locked = false

func _on_body_entered(body: Node):
    if not body.is_in_group("player"):
        return
    print("locked? ", locked)
    if locked == false:
        transition_requested.emit(target)

