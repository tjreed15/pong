class_name Ball extends CharacterBody2D


const MAX_BOUNCE_ANGLE: float = PI/4
const MIN_SPEED: float = 100
const MAX_SPEED: float = 3000


@onready var color_rect: ColorRect = $ColorRect
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


@export var initial_speed: float = 800.0
@export var color: Color = Color.WHITE :
	set(new_value):
		color = new_value
		if not is_node_ready():
			await ready
		self.color_rect.color = new_value


func _physics_process(delta: float) -> void:
	var collision_info = self.move_and_collide(self.velocity * delta)
	if collision_info:
		self.audio_player.play()
		self.set_direction(self.velocity.bounce(collision_info.get_normal()))
		SignalBus.ball_collided.emit(self, collision_info.get_collider())
		

func set_speed(speed: float) -> void:
	self.velocity = self.velocity.normalized() * clampf(speed, MIN_SPEED, MAX_SPEED)


func set_direction(direction: Vector2) -> void:
	var normalized_vel = Vector2(abs(direction.x), direction.y).normalized()
	var angle = clamp(normalized_vel.angle(), -MAX_BOUNCE_ANGLE, MAX_BOUNCE_ANGLE)
	var vel_dir = Vector2.RIGHT.rotated(angle)
	self.velocity = Vector2(vel_dir.x * sign(direction.x), vel_dir.y) * min(direction.length(), MAX_SPEED)
