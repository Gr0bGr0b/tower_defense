class_name Actor
extends Node2D


@onready var state_machine	 	= $StateMachine
@onready var atk_area_detection		= $AttackArea2D
@onready var animation_player	= $AnimationPlayer
@onready var sprite 			= $Sprite2D

@export var speed : float =  150.0 

signal animation_changed(anim: String)

var animation : String = "" : set = set_animation, get = get_animation
var direction : Vector2 = Vector2.ZERO: set = set_direction, get = get_direction
var target : Area2D = null : set = set_target, get = get_target

######## ACCESSORS ########

func set_animation(value) -> void:
		if animation != value :
			animation = value
			emit_signal("animation_changed", value)
			
func get_animation() -> String:
		return animation


func set_direction(value) -> void:
		if value != direction && value != Vector2.ZERO:
			direction = value
			emit_signal("direction_changed", value)
			
func get_direction() -> Vector2:
		return direction

func set_target(value: Area2D) -> void:
	if value != target:
		target = value

func get_target() -> Area2D:
	return target

######## BUILT-IN ########
func _ready() -> void:
	self.animation_changed.connect(_on_animation_changed)
	state_machine.init(self)
	
	atk_area_detection.connect("area_entered", Callable(self, "_on_atk_area_entered"))
	atk_area_detection.connect("area_exited", Callable(self, "_on_atk_area_exited"))

func _physics_process(delta):
	state_machine.physics_process(delta)

func _process(delta):
	state_machine.process(delta)
	
######## SIGNALS ########
func _on_animation_changed(anim: String):
	animation_player.play(anim)

