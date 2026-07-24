class_name HurtboxComponent extends Area2D

@onready var health_component: HealthComponent = get_parent().get_node("HealthComponent")

func damage(amount: float) -> void:
	health_component.damage(amount)