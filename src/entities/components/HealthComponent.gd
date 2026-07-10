class_name HealthComponent extends Node

signal health_depleted

@export var max_health: float = 100.0
var current_health: float

func _ready() -> void:
	reset_health(max_health)

func damage(amount: float) -> void:
	if current_health <= 0:
		return
	current_health -= amount
	if current_health <= 0:
		health_depleted.emit()

func reset_health(amount: float) -> void:
	max_health = amount
	current_health = max_health