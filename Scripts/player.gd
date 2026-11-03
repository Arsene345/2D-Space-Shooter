class_name Player
extends Area2D

@export var speed: float  = 600.0
@export var max_rotation:float=90
var screen_size: Vector2
var acceleration: float=3000.0
var velocity: Vector2=Vector2.ZERO
var lp: int = 3
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	screen_size=get_viewport_rect().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var targetVelocity:Vector2=read_direction()*speed
	velocity=velocity.move_toward(targetVelocity,acceleration*delta)
	position+=velocity*delta
	position.x = clamp(position.x,0,screen_size.x)
	rotation_degrees=deg_to_rad(max_rotation)*velocity.x*delta
	
func read_direction() -> Vector2:
		var direction : Vector2 =Vector2.ZERO
		direction.x=Input.get_axis("move_left","move_right")
		
		if Input.is_action_pressed("touch"):
			var xDestination: float = get_global_mouse_position().x
			var distance_to_finger: float=xDestination-position.x
			direction.x = clamp(distance_to_finger/60,-1.0,1.0)
		
		return direction

func take_damage (amount:int)->void:
	lp-=amount
	if (lp<=0):
		get_tree().reload_current_scene.call_deferred()
	pass
