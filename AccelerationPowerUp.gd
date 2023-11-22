class_name AccelerationPowerUp extends Node

@export var min_paddle_speed: float = 400
@export var power_up_delay: float = 0.5
@export var ball_speed_up: float = 1.5

@onready var paddle: Paddle = self.get_parent()
@onready var pervious_position: float = self.paddle.global_position.y
var timer: Timer


func _ready() -> void:
	self.paddle.hit_ball.connect(self.hit_ball)
	self.timer = Timer.new()
	add_child(self.timer)
	self.timer.one_shot = true

func hit_ball(ball: Ball):
	if not timer.is_stopped():
		ball.velocity *= self.ball_speed_up

func _process(delta: float) -> void:
	var dist = self.paddle.global_position.y - self.pervious_position
	self.pervious_position = self.paddle.global_position.y
	var speed = dist / delta
	if speed > self.min_paddle_speed:
		self.timer.start(self.power_up_delay)
