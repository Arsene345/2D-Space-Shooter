extends Node

var score :int=0
var hitstop_id:int =0

signal score_changed(score:int) 

func add_score(score:int)->void:
	self.score+=score
	score_changed.emit(self.score)

signal player_life_changed (life:int)

signal game_over()

func trigger_game_over()->void:
	get_tree().paused=true
	game_over.emit()

func restart()->void:
	score=0
	get_tree().reload_current_scene.call_deferred()
	get_tree().paused=false

func hitstop(duration:float)->void:
	hitstop_id +=1
	var current_id : int =hitstop_id
	Engine.time_scale = 0.05
	await get_tree().create_timer(
		duration,
		true,
		false,
		true
	).timeout
	if current_id == hitstop_id:
		Engine.time_scale = 1.0
	
