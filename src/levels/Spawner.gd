class_name Spawner extends Marker2D

@export var def: EnemyData
@export var container: Node2D

func _ready() -> void:
    spawn.call_deferred()


func spawn() -> Node:
        if def == null:
           push_error("Def null") 
           return
        if container == null:
            push_error("Container null")
            return
        if def.scene == null:
            push_error("def.scene null")
            return
        var enemy = def.scene.instantiate()
        enemy.configure(def, null)
        container.add_child(enemy)
        enemy.global_position = global_position
        return enemy
