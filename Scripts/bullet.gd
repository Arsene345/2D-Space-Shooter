class_name  Bullet
extends Area2D

@export var speed: float = 2000.0
@export var hit_fx : PackedScene
@export_range(0,PI,PI/100) var rotation_range : float= 3*PI/180

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.pitch_scale=randf_range(0.5,3.0)
	$AudioStreamPlayer2D.play()
	rotation = randf_range(-rotation_range,rotation_range)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#position.y-=speed*delta
	position += Vector2.UP.rotated(rotation) * speed * delta
	if (position.y <= -$LaserBlue02.texture.get_width() ):
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(1)
		var hit:Node2D= hit_fx.instantiate()
		queue_free()
	pass # Replace with function body.
