extends Node2D
@export var bullet_scene : PackedScene
@export var time_between_shots : float = 0.5
var cooldown: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooldown-=delta
	
	if  cooldown <= 0.0:
		cooldown=time_between_shots
	
		var bullet: Area2D = bullet_scene.instantiate()
		bullet.global_position=Vector2(global_position.x,global_position.y)
		get_tree().current_scene.add_child(bullet)
