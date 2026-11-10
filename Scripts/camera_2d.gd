extends Camera2D

@export var max_offser: Vector2 = Vector2(10.0,10.0)
@export var max_rotation :float = 0.05
@export var trauma_decay :float = 1.5

var trauma:float = 0.0
var trauma_power:float=2




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if trauma>0.0:
		trauma = max(trauma - trauma_decay*delta,0.0)
		
		var shake : float = pow(trauma,trauma_power)
		
		offset = Vector2( (randf_range(-1.0,1.0)*max_offser.x),(randf_range(-1.0,1.0)* max_offser.y))
		rotation= randf_range(-1.0,1.0)*max_rotation*shake
		
func add_trauma(amount: float) -> void:
	trauma = clamp(trauma + amount, 0.0, 2.5) 
