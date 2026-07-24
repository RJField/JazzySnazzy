extends CharacterBody2D

signal player_death_event

@onready var health_component: HealthComponent = $HealthComponent

@export var speed: float = 200.0
@export var bullet_scene : PackedScene

var _dying: bool = false


func _ready() -> void:
    add_to_group("player")
    health_component.health_depleted.connect(_on_death)

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

func _on_death() -> void:
    if _dying:
        return
    _dying = true
    set_physics_process(false)
    player_death_event.emit()
    queue_free()