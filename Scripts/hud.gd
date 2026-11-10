extends CanvasLayer

@onready var score_label: Label = $Label
@onready var death_screen:Control=$Control
@onready var damage:ColorRect=$ColorRect
@onready var life:HBoxContainer=$HBoxContainer

var score_tween: Tween

func _ready() -> void:
	death_screen.visible=false

	GameManager.score_changed.connect(on_global_score_changed)
	GameManager.player_life_changed.connect(on_player_life_changed)
	score_label.pivot_offset = score_label.size / 2


func on_global_score_changed(score: int) -> void:
	score_label.text = "SCORE : %06d" % score
	if score_tween and score_tween.is_running():
		score_tween.kill()
	score_label.scale = Vector2.ONE
	score_tween = create_tween()
	score_tween.tween_property(
		score_label,
		"scale",
		Vector2(1.4, 1.4),
		0.5
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	score_tween.tween_property(
		score_label,
		"scale",
		Vector2.ONE,
		0.5
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
func on_player_life_changed(new_life:int)->void:
	damage.color=Color(1.0,0,0,0.4)
	var flash_tween: Tween=get_tree().create_tween()
	flash_tween.tween_property(damage,"color",Color(1.0,0,0,0),1)
	flash_tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	flash_tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	flash_tween.play()
	for i:int in life.get_child_count():
		var heart:TextureRect = life.get_child(i)
		heart.visible = i < new_life
		if new_life==0:
			death_screen.visible=true

func _on_restart_pressed() -> void:
	GameManager.restart()

func _on_quit_pressed() -> void:
	get_tree().quit()
