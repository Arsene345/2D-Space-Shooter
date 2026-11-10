class_name Enemy
extends Area2D

@export var speed: float  = 600.0
@onready var flash_timer:Timer=$flashTimer
@export var lp : int = 3
@export var knockback_force: float=100
@export var explosion_fx : PackedScene
@onready var enemy:Sprite2D=$Sprite2D
@onready var cam: Camera2D=$"../Camera2D"




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y+=speed*delta
	if position.y >1200.0 + enemy.texture.get_width():
		queue_free()
	pass

func take_damage(amount:int)->void:
	lp-=amount
	position.y-=knockback_force
	
	enemy.modulate=Color(10,10,10)
	flash_timer.start()
	GameManager.add_score(5)

	
	if lp<=0:
		var explosion:Node2D= explosion_fx.instantiate()
		explosion.global_position=Vector2(global_position.x,global_position.y)
		get_tree().current_scene.add_child(explosion)
		cam.add_trauma(0.1)
		GameManager.hitstop(0.1)
		GameManager.add_score(10)
		
		queue_free()
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(1)
		queue_free()
	pass # Replace with function body.


func _on_flash_timer_timeout() -> void:
	enemy.modulate=Color.WHITE
	pass # Replace with function body.
