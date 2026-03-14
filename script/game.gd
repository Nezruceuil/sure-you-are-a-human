extends Control
var turn = 0
var direction = 1
var level = null
var lev = null
var check_toggle
var mov = 0
var anim = 0

@onready var label: Label = $"1/Label"
@onready var scene: Node2D = $Node2D

@onready var bobling_start: Node2D = $bobling_start


@onready var human_check: Control = $human_check
@onready var check: CheckButton = $human_check/check
@onready var submit: CheckButton = $human_check/submit

@onready var _1: Label = $"3/1"
@onready var _2: Label = $"3/2"
@onready var _3: Label = $"3/3"
@onready var _4: Label = $"3/4"
@onready var _5: Label = $"3/5"
@onready var _6: Label = $"3/6"

@onready var lv_1s: Label = $"4/lv1s2"
@onready var lv_2s: Label = $"4/lv2s2"
@onready var lv_3s: Label = $"4/lv3s2"

@onready var options: Panel = $Node2D/options
@onready var delete: Panel = $Node2D/Delete

@onready var music: HSlider = $Node2D/options/Music
@onready var sfx: HSlider = $Node2D/options/SFX


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Var.check = false
	bobling_start.visible = true
	options.visible = false
	delete.visible = false
	music.value = Var.Music
	sfx.value = Var.SFX


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_1.visible = Var.advancements[0]
	_2.visible = Var.advancements[1]
	_3.visible = Var.advancements[2]
	_4.visible = Var.advancements[3]
	_5.visible = Var.advancements[4]
	_6.visible = Var.advancements[5]
	
	lv_1s.text = str(Var.score[0]) + "s"
	lv_2s.text = str(Var.score[1]) + "s"
	lv_3s.text = str(Var.score[2]) + "s"
	
	if anim == 0:
		if Var.gone == false:
			if mov < 150:
				bobling_start.move_local_x(180 * delta)
				mov += delta*90
			elif mov > 149:
				if Var.has_dialogue == false:
					Var.has_dialogue = true
					DialogueManager.show_dialogue_balloon(preload("uid://benpnffi8d38y"))
		else:
			if mov > 0:
				bobling_start.move_local_x(-180 * delta)
			else:
				level = 0
				anim = 1
				bobling_start.visible = false
			mov -= delta*90
		
	
	
	if direction == 1:
		if turn < 80:
			turn += 1
		else:
			direction *= -1
	elif direction == -1:
		if turn > -80:
			turn -= 1
		else:
			direction *= -1
	label.rotation = turn * 0.0005
	
	if Var.check == false:
		human_check.visible = false
		check.button_pressed = false
		submit.button_pressed = false
	else:
		human_check.visible = true


func _on_play_pressed() -> void:
	if level == 0:
		scene.move_local_y(648)
		level = 1


func _on_advancements_pressed() -> void:
	if level == 0:
		scene.move_local_x(1152)
		level = 2


func _on_quit_pressed() -> void:
	if level == 0:
		scene.move_local_x(-1152)
		level = 3


func _on_quit2_pressed() -> void:
	pass # Replace with function body.


func _on_return_pressed() -> void:
	if level == 1:
		scene.move_local_y(-648)
		level = 0


func _on_submit_toggled(toggled_on: bool) -> void:
	if check_toggle == true:
		Var.check = false
	else:
		submit.button_pressed = false


func _on_check_toggled(toggled_on: bool) -> void:
	check_toggle = toggled_on
	if check_toggle == true:
		check.modulate = "00ff00"
	else:
		check.modulate = "ffffff"


func _on_return_2_pressed() -> void:
	if level == 2:
		scene.move_local_x(-1152)
		level = 0


func _on_bobling_pressed() -> void:
	if level == 2:
		if Var.has_dialogue == false:
			Var.has_dialogue = true
			Var.dialogue = 1
			DialogueManager.show_dialogue_balloon(preload("uid://benpnffi8d38y"))


func _on_lv_1_pressed() -> void:
	if level == 1:
		get_tree().change_scene_to_file("res://scene/lv_1.tscn")


func _on_lv_2_pressed() -> void:
	if level == 1:
		get_tree().change_scene_to_file("res://scene/lv_2.tscn")

func _on_lv_3_pressed() -> void:
	if level == 1:
		get_tree().change_scene_to_file("res://scene/lv_3.tscn")

func _on_return_3_pressed() -> void:
	if level == 3:
		scene.move_local_x(1152)
		level = 0


func _on_option_pressed() -> void:
	if not level == null:
		if level < 4:
			lev = level
			options.visible = true
			level = 4
		elif level == 4:
			options.visible = false
			level = lev

func _on_quit_option_pressed() -> void:
	if level == 4:
		options.visible = false
		level = lev


func _on_delete_pressed() -> void:
	if level == 4:
		delete.visible = true
		level = 5


func _on_yes_pressed() -> void:
	Save._delete_save()


func _on_no_pressed() -> void:
	if level == 5:
		delete.visible = false
		level = 4


func _on_music_value_changed(value: float) -> void:
	if level == 4:
		Var.Music = value
	else:
		music.value = Var.Music


func _on_sfx_value_changed(value: float) -> void:
	if level == 4:
		Var.SFX = value
	else:
		sfx.value = Var.SFX
