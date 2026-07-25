class_name Weapon extends Node2D

var _def : WeaponDef

func configure(def: WeaponDef):
    _def = def
    if _def == null:
        return
    $Sprite2D.texture = def.base_sprite #default base sprite for each weapon
    $Muzzle.position = def.muzzle_offset #allows us to have custom muzzle positions easily


func fire():
    if _def == null:
        return
    var p = _def.projectile.instantiate()
    get_tree().root.add_child(p)
    p.set_damage(_def.weapon_base_damage) #this needs to be updated eventually once we introduce weapon mods. Right now it takes only the base damage.
    p.global_transform = $Muzzle.global_transform 