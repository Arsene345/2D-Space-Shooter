class_name Enemy
extends Area2D

@export var speed: float  = 600.0
@onready var flash_timer:Timer=$flashTimer
@export var lp : int = 3
@export var knockback_force: float=100
@export var explosion_fx : PackedScene



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y+=speed*delta
	if position.y >1200.0 + $Sprite2D.texture.get_width():
		queue_free()
	pass

func take_damage(amount:int)->void:
	lp-=amount
	position.y-=knockback_force
	
	$Sprite2D.modulate=Color(10,10,10)
	flash_timer.start()
	
	if lp<=0:
		var explosion:Node2D= explosion_fx.instantiate()
		explosion.global_position=Vector2(global_position.x,global_position.y)
		get_tree().current_scene.add_child(explosion)
		queue_free()
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(1)
		queue_free()
	pass # Replace with function body.


func _on_flash_timer_timeout() -> void:
	$Sprite2D.modulate=Color.WHITE
	pass # Replace with function body.
