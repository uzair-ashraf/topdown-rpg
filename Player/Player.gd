extends KinematicBody2D

# The vector 2 in all four directions will never go higher than this
const MAX_SPEED := 120
# This is used to multiply the normalized vector as it is being incremented
const ACCELERATION := 60
# The friction is used to slow down the character as the user let's go, keeps it from stopping immediately
const FRICTION := 400

var velocity := Vector2.ZERO

onready var animationTree := $AnimationTree
onready var animationStateMachine = animationTree.get("parameters/playback")

func _physics_process(delta):
	return handleMovement(delta)

func handleMovement(delta) -> void:
	var inputVector := getMovementVector()

	if inputVector != Vector2.ZERO:
		setAnimationTree("Run", inputVector)
		setAnimationTree("Idle", inputVector)
		animationStateMachine.travel("Run")
		velocity += inputVector * ACCELERATION
	else:
		animationStateMachine.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)

	velocity = velocity.clamped(MAX_SPEED)
	velocity = move_and_slide(velocity)

func setAnimationTree(animation: String, inputVector: Vector2) -> void:
	animationTree.set(
		"parameters/" + animation + "/blend_position",
		inputVector
	)

func getMovementVector() -> Vector2:
	return Vector2(
		(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")),
		(Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	).normalized()
