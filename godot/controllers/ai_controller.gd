class_name AIController extends Node


@export var max_speed: float = 500 # 1000.0
@export var deviations: float = 1 # 3 # Number of stdevs to fall on paddle
@export var linger_speed: float = max_speed/2.0

@onready var paddle: Paddle = self.get_parent()
@onready var ball: Ball = get_node("/root/Main/Ball")

var paddle_offset: float = 0


func _ready() -> void:
	SignalBus.ball_collided.connect(self.ball_collided)


func _physics_process(delta: float) -> void:
	if not self.ball:
		return
	if sign(self.ball.velocity.x) * sign(self.paddle.get_normal().x) == -1:
		self.__move_towards_ball(delta)
	else:
		self.__linger(delta)


func ball_collided(_ball: Ball, with: Object) -> void:
	if with == self.paddle:
		self.paddle_offset = randfn(0, self.paddle.color_rect.size.y/(2*self.deviations))


func __linger(delta: float):
	self.__move_towards(Constants.SCREEN_CENTER.y, self.linger_speed * delta)


func __move_towards_ball(delta: float):
	self.__move_towards(self.ball.global_position.y - self.paddle_offset, self.max_speed * delta)


func __move_towards(y_pos: float, speed: float):
	var distance = y_pos - self.paddle.global_position.y
	self.paddle.move_and_collide(Vector2(0, sign(distance) * min(abs(distance), speed)))
