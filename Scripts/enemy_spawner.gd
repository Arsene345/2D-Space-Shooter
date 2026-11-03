extends Node2D

@export var enemy_scene:PackedScene
@export var time_between_spawn:float=0.15
@export var start_cooldown:float=0.0
var cooldown:float = start_cooldown
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooldown-=delta
	if cooldown<=0.0:
		cooldown=time_between_spawn
		var enemy:Area2D = enemy_scene.instantiate()
		enemy.global_position = Vector2(randf_range(0,700) , -60)
		get_tree().current_scene.add_child(enemy)
	pass
