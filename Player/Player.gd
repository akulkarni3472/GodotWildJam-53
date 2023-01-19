extends KinematicBody

export var speed = 8.0
export var lerp_val = 0.2
export var jump_force = 20.0
export var gravity = 50

var velocity = Vector3.ZERO
var snap_vector = Vector3.DOWN

onready var spring_arm= $SpringArm
onready var model = $MeshInstance

func _ready():
	#spring_arm.add_excluded_object(get_rid())
	pass

func _physics_process(delta):
	apply_gravity(delta)
	move()
	jump()
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector3.UP, true)
	
func _process(delta):
	spring_arm.translation = translation

func move():
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength("right") - Input.get_action_raw_strength("left")
	move_dir.z = Input.get_action_strength("back") - Input.get_action_raw_strength("forward")
	move_dir = move_dir.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	velocity.x = move_dir.x * speed
	velocity.z = move_dir.z * speed
	if move_dir.z != 0 or move_dir.x != 0:
		model.rotation.y = lerp_angle(model.rotation.y, atan2(velocity.x, velocity.z), lerp_val)

func apply_gravity(delta):
	velocity.y -= delta * gravity

func jump():
	var landed = is_on_floor() and snap_vector == Vector3.ZERO
	var jumping = is_on_floor() and Input.is_action_just_pressed("jump")
	
	if jumping:
		snap_vector = Vector3.ZERO
		velocity.y = jump_force
	elif landed:
		snap_vector = Vector3.DOWN
