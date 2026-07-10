extends CharacterBody2D

signal death_event

@onready var health_component: HealthComponent = $HealthComponent

var speed: float
var _dying: bool = false
var _def: EnemyData
var _target: Node2D

func _ready() -> void:
	_apply_configuration()
	health_component.health_depleted.connect(_on_death)

func _physics_process(_delta: float) -> void:
	velocity = Vector2.RIGHT * speed
	move_and_slide()

func _on_death() -> void:
	if _dying:
		return
	_dying = true
	set_physics_process(false)
	death_event.emit()
	queue_free()

func configure(def: EnemyData, target: Node2D) -> void:
	_def = def
	_target = target

func _apply_configuration() -> void:
	if _def == null:
		push_warning("Enemy spawned without a def, using inspector values")
		return
	speed = _def.speed
	health_component.reset_health(_def.max_health)