extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 7.0
export var jump_force = 20.0
export var gravity = 9.8

var _velocity = Vector3.ZERO
var _snap_vector = Vector3.DOWN

onready var _spring_arm: SpringArm = $SpringArm
# onready var _model: Spatial = 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var move_dir = Vector3.ZERO
