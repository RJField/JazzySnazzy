class_name WeaponDef extends Resource


#weapon description and art
@export var display_name: String
@export var base_sprite: Texture2D
@export var scene : PackedScene

#weapon stats
@export var weapon_base_damage: float = 10.0
@export var fire_rate: float = 1.0

#firing
@export var projectile : PackedScene #this will need to change as we introduce non projectile based weapons (beams, aoe zones, hitscans)
@export var muzzle_offset: Vector2 #this will need some work, and on that note we need to also look at weapon offsets and positioning eventually.

#capacity
@export var max_mod_count : int