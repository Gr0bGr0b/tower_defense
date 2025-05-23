class_name Actor
extends CharacterBody2D


@onready var state_machine	 	= $StateMachine
@onready var atk_area_detection		= $AttackArea2D
@onready var animation_player	= $AnimationPlayer
@onready var sprite 			= $Sprite2D
@onready var health_bar : TextureProgressBar = $Control/HealthBar

@export var speed : float =  150.0 
@export var health: int = 20 : set = set_health, get = get_health
@export var damage: int = 10

signal animation_changed(anim: String)
signal died
signal health_changed(health: int)

var animation : String = "" : set = set_animation, get = get_animation
var direction : Vector2 = Vector2.ZERO: set = set_direction, get = get_direction
var target= null : set = set_target, get = get_target

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
			
func get_direction() -> Vector2:
		return direction

func set_target(value: Node2D = null) -> void:
	if value != target:
		target = value
		if target != null:
			target.connect("died", Callable(self,"_on_target_died"))

func get_target() -> Node2D:
	return target
	
func set_health(value: int) -> void:
	if health != value:
		health = value
		emit_signal("health_changed", health)

func get_health() -> int:
	return health

######## BUILT-IN ########
func _ready() -> void:
	health_bar.max_value = get_health()
	self.health_changed.connect(_on_health_changed)
	self.animation_changed.connect(_on_animation_changed)
	atk_area_detection.connect("area_entered", Callable(self, "_on_atk_area_entered"))
	atk_area_detection.connect("area_exited", Callable(self, "_on_atk_area_exited"))
	atk_area_detection.connect("body_entered", Callable(self, "_on_atk_area_entered"))
	atk_area_detection.connect("body_exited", Callable(self, "_on_atk_area_exited"))
	
	state_machine.init(self)
	
	
func _physics_process(delta):
	state_machine.physics_process(delta)

func _process(delta):
	state_machine.process(delta)
	
######## LOGIC ########

func hit(damage: int) -> void:
	set_health(get_health() - damage)
	if get_health() <= 0:
		_died()

func _died() -> void:
	queue_free()
	emit_signal("died")
	
######## SIGNALS ########
func _on_animation_changed(anim: String):
	animation_player.play(anim)
	
func _on_target_died() -> void:
	# Only check fore areas has normally no enemies can be 
	# on the same position
	target.disconnect("died", Callable(self, "_on_target_died"))
	if atk_area_detection.has_overlapping_areas():
		set_target(atk_area_detection.get_overlapping_areas()[0])
	else:
		set_target(null)

func _on_health_changed(health: int) -> void:
	health_bar.set_value(health)
