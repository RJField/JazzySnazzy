extends Area2D

@onready var hitbox: HitboxComponent = $HitboxComponent

@export var speed: float = 500.0

func _ready() -> void:
    hitbox.hit_confirmed.connect(_on_hit_confirmed)
    hitbox.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
    position += transform.x * speed * delta

func _on_hit_confirmed() -> void:
    queue_free()

func _on_body_entered(body: Node) -> void:
   queue_free()

func set_damage(damage: float) -> void:
    hitbox.damage_amount = damage
    print("damage set to ", hitbox.damage_amount)