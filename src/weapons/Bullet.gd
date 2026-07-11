extends Area2D

@export var damage_amount: float = 10.0
@export var speed: float = 500.0

func _ready() -> void:
    area_entered.connect(_on_area_entered)
    body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
    position += transform.x * speed * delta

func _on_area_entered(area: Area2D) -> void:
    if area.has_method("damage"):
        area.damage(damage_amount)
        queue_free()

func _on_body_entered(body: Node) -> void:
    queue_free()