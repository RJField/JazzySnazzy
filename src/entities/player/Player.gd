extends CharacterBody2D

signal player_death_event

@onready var health_component: HealthComponent = $HealthComponent

@export var speed: float = 200.0
@export var weapon_scene : PackedScene
@export var starting_wdef : WeaponDef

var _dying: bool = false
var _current_weapon: Weapon

func _ready() -> void:
    add_to_group("player")
    health_component.health_depleted.connect(_on_death)
    
    #sets up the starting weapon and equips it
    var initial_weapon_loadout: WeaponLoadout = WeaponLoadout.new()
    initial_weapon_loadout.def = starting_wdef
    equip(initial_weapon_loadout)

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
    if _current_weapon:
        _current_weapon.fire()

func _on_death() -> void:
    if _dying:
        return
    _dying = true
    set_physics_process(false)
    player_death_event.emit()
    queue_free()

func equip(loadout: WeaponLoadout):
    if _current_weapon:
        _current_weapon.queue_free()
    var w = weapon_scene.instantiate()
    $WeaponPivot.add_child(w)
    w.configure(loadout.def)
    _current_weapon = w