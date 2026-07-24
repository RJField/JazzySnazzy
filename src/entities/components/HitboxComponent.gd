class_name HitboxComponent extends Area2D

signal hit_confirmed
signal body_hit_entered

@export var damage_amount : float = 10.0

func _ready() -> void:
    area_entered.connect(_on_area_entered)
    body_entered.connect(_on_body_entered)

func _on_area_entered(area: Area2D) -> void:
    if area.has_method("damage"):
        area.damage(damage_amount)
        hit_confirmed.emit()

func _on_body_entered(body: Node2D) -> void:
    body_hit_entered.emit()