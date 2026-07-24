class_name EnemyData extends Resource

# static 
@export var display_name: String = "Default Monster"
@export var scene: PackedScene
@export var texture: Texture2D

#dynamic
@export var speed: float = 20.0
@export var max_health: float = 100.0
@export var behaviors: Array[EnemyBehavior]