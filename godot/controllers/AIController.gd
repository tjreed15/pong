class_name AIController extends Node

@export var maxSpeed: float = 150.0
@export var lingerSpeed: float = maxSpeed/2.0

@onready var paddle: Paddle = self.get_parent()
@onready var ball: Ball = get_node("/root/Main/Ball")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not self.ball:
		return
	if sign(self.ball.velocity.x) * sign(self.paddle.get_normal().x) == -1:
		self.__move_towards_ball(delta)
	else:
		self.__linger(delta)
	
func __linger(delta: float):
	self.__move_towards(720/2.0, self.lingerSpeed * delta)

func __move_towards_ball(delta: float):
	self.__move_towards(self.ball.position.y, self.maxSpeed*delta)
	
func __move_towards(y_pos: float, speed: float):
	var distance = y_pos - self.paddle.global_position.y
	self.paddle.global_position.y += sign(distance) * min(abs(distance), speed)
	
