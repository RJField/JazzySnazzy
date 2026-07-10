extends CharacterBody2D

@export var speed: float = 200.0
@export var bullet_scene : PackedScene


func _ready() -> void:
    add_to_group("player")

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("attack"):
        attack()

func _physics_process(_delta):
    var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = direction * speed
    move_and_slide()
    look_at_mouse()

func look_at_mouse() -> void:
    look_at(get_global_mouse_position())

func attack():
    var b = bullet_scene.instantiate()
    get_tree().root.add_child(b)
    b.global_transform = $WeaponPivot.global_transform