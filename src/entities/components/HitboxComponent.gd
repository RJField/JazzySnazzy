class_name HitboxComponent extends Area2D

signal hit_confirmed
signal body_hit_entered

@export var damage_amount : float = 10.0
@export var collision_cooldown : float = 0.0

var overlapping_areas: Array[Area2D] = []
var last_hit_times: Dictionary = {}

func _ready() -> void:
    area_entered.connect(_on_area_entered)
    area_exited.connect(_on_area_exited)
    body_entered.connect(_on_body_entered)
    print("Hitbox component running for", get_parent())

#when an overlap is detected, add the overlapping object/area to the array tracking currently overlapping areas.
func _on_area_entered(area: Area2D) -> void:
    if area.has_method("damage"):
        overlapping_areas.append(area)
        print("Added area / parent", area, area.get_parent().name)
        if not area.tree_exiting.is_connected(_on_tracked_area_freed):
            area.tree_exiting.connect(_on_tracked_area_freed.bind(area))

#when an overlap is not longer occuring, remove the previously overlapping area from the array
func _on_area_exited(area: Area2D) -> void:
    overlapping_areas.erase(area)
    
#when you hit a wall/object
func _on_body_entered(body: Node2D) -> void:
    body_hit_entered.emit()

func _physics_process(delta: float) -> void:
    var now := Time.get_ticks_msec()
    for area in overlapping_areas:
        var last_hit = last_hit_times.get(area, -INF)
        if now - last_hit >= collision_cooldown * 1000:
            area.damage(damage_amount)
            print("Damage dealt to:", area.get_name(), " by ",  get_parent().name)
            hit_confirmed.emit()
            last_hit_times[area] = now

func _on_tracked_area_freed(area: Area2D) -> void:
    overlapping_areas.erase(area)
    last_hit_times.erase(area)
