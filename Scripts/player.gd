class_name Player
extends Area2D

@export var speed: float  = 600.0
@export var max_rotation:float=90
@export var explosion_scene : PackedScene
@onready var death_sound:AudioStreamPlayer2D=$death
@onready var damage_sound:AudioStreamPlayer2D=$degat
var is_invincible: bool = false
var tween: Tween

var screen_size: Vector2
var acceleration: float=3000.0
var velocity: Vector2=Vector2.ZERO
var lp: int = 3
@onready var cam: Camera2D=$"../Camera2D"
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
	if is_invincible:
		return
	lp-=amount
	GameManager.player_life_changed.emit(lp)
	cam.add_trauma(80)
	damage_sound.play()
	GameManager.hitstop(0.1)
	start_invincibility()
	if (lp<=0):
		death_sound.play()
		var explosion:Node2D = explosion_scene.instantiate()
		get_tree().current_scene.add_child(explosion)
		explosion.global_position = global_position
		explosion.scale = Vector2(2.0, 2.0)

		GameManager.trigger_game_over()
	pass
	
func start_invincibility() -> void:
	is_invincible = true
	$"invincibilité".start()
	tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "modulate:a", 0.2, 0.1)
	tween.tween_property(self, "modulate:a", 1.0, 0.1)
	


func _on_invincibilité_timeout() -> void:
	is_invincible = false
	modulate.a = 1.0
	if tween and tween.is_running():
		tween.kill()

	tween = null
