class_name EnemyData extends Resource

@export var max_health: float = 100.0
@export var speed: float = 20.0
@export var display_name: String = "Default Monster"
@export var scene: PackedScene
@export var behaviors: Array[EnemyBehavior]
@export var texture: Texture2D