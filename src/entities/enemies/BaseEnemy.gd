extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent

var speed: float = 20.0
var _dying: bool = false

func _ready() -> void:
	health_component.health_depleted.connect(_on_death)

func _physics_process(_delta: float) -> void:
	velocity = Vector2.RIGHT * speed
	move_and_slide()

func _on_death() -> void:
	if _dying:
		return
	_dying = true
	queue_free()