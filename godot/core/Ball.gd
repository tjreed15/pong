class_name Ball extends CharacterBody2D

const MAX_BOUNCE_ANGLE: float = PI/4
const MIN_SPEED: float = 100
const MAX_SPEED: float = 3000

@onready var colorRect: ColorRect = $ColorRect
@onready var collisionShape: CollisionShape2D = $CollisionShape2D

@export var initial_speed: float = 800.0
@export var color: Color = Color.WHITE :
	set(new_value):
		color = new_value
		if not is_node_ready():
			await ready
		self.colorRect.color = new_value

func _physics_process(delta: float) -> void:
	var collisionInfo = self.move_and_collide(self.velocity * delta)
	if collisionInfo:
		self.set_direction(self.velocity.bounce(collisionInfo.get_normal()))
		SignalBus.ball_collided.emit(self, collisionInfo.get_collider())

func set_speed(speed: float) -> void:
	self.velocity = self.velocity.normalized() * clampf(speed, MIN_SPEED, MAX_SPEED)

func set_direction(direction: Vector2) -> void:
	var normalized_vel = Vector2(abs(direction.x), direction.y).normalized()
	var angle = clamp(normalized_vel.angle(), -MAX_BOUNCE_ANGLE, MAX_BOUNCE_ANGLE)
	var vel_dir = Vector2.RIGHT.rotated(angle)
	self.velocity = Vector2(vel_dir.x * sign(direction.x), vel_dir.y) * min(direction.length(), MAX_SPEED)
