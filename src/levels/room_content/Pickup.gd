extends Area2D

var _def

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func configure(def):
    _def = def
    $Sprite2D.texture = def.base_sprite
    return

func _on_body_entered(body : CharacterBody2D):
    if body.is_in_group("player"):
        var loadout = WeaponLoadout.new()
        loadout.def = _def
        body.equip(loadout)
        queue_free()
    return