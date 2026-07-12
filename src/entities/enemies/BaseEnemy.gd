extends CharacterBody2D

signal death_event

@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite: Sprite2D = $Sprite2D

var speed: float
var _dying: bool = false #RIP
var _def: EnemyData #defines enemy type
var _target: Node2D
var behavior_states: Array[BehaviorState] #movement patterns etc

func _ready() -> void:
	health_component.health_depleted.connect(_on_death)

func _physics_process(_delta: float) -> void:
	if behavior_states.is_empty():
		return
	var active_state = behavior_states[0]
	velocity = active_state.tick(self, _target, _delta) * speed
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
	if _def == null:
		return
	speed = _def.speed #need to ensure we define this here, otherwise it will not be moved to local
	sprite.texture = _def.texture
	_target = target
	health_component.reset_health(_def.max_health)
	for behavior in _def.behaviors:
		behavior_states.append(behavior.create_state())

# This function became obsolete. Keeping as memory. It was used to set some stats on a new enemy, but it created a bug and became redundant through the fix on 7/11/26
#func _apply_stats() -> void:
#	if _def == null:
#		print("Enemy spawned without a def, using inspector values")
#		return
#	speed = _def.speed

func set_target(body: CharacterBody2D):
	_target = body
