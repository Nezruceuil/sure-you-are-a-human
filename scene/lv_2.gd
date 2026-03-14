extends Node2D

var check_toggle = false
@onready var check: CheckButton = $Control/human_check/check
@onready var submit: CheckButton = $Control/human_check/submit
@onready var human_check: Control = $Control/human_check
@onready var charge: Sprite2D = $charge
var chargetime = 0
@onready var fake: Panel = $Control/fake

var timer = 0
@onready var time: Label = $time

var done = 15
@onready var redo: Label = $redo

var inversed = false

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Var.check = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	redo.text = str(done)
	
	time.text = "Total Time: " + str(round(timer*100)/100)
	if done > 0:
		timer += delta
		if Var.check == false:
			fake.visible = true
			charge.rotate(0.25)
			chargetime += delta
			if  chargetime > 0.1:
				check.button_pressed = false
				submit.button_pressed = false
				charge.visible = false
				charge.rotation = 0
				chargetime = 0
				Var.check = true
			else:
				charge.visible = true
				if rng.randi_range(1,2) == 1:
					inversed = false
					check.text = "I'm a Human !"
				else:
					inversed = true
					check.text = "I'm a Robot !"
		else:
			fake.visible = false
			charge.visible = false
			human_check.visible = true
	else:
		if timer < Var.score[1]:
			Var.score[1] = round(timer*1000)/1000
			if Var.score[1] < 10:
				Var.advancements[2] = true
			Save._save()
		get_tree().change_scene_to_file("res://scene/game.tscn")



func _on_submit_toggled(toggled_on: bool) -> void:
	if check_toggle == true and inversed == false or check_toggle == false and inversed == true:
		Var.check = false
		done -= 1
	else:
		submit.button_pressed = false


func _on_check_toggled(toggled_on: bool) -> void:
	check_toggle = toggled_on
	if check_toggle == true:
		check.modulate = "00ff00"
	else:
		check.modulate = "ffffff"
