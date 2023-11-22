class_name Paddle extends CharacterBody2D

signal hit_ball(ball: Ball)

@onready var colorRect: ColorRect = $ColorRect
@onready var collisionShape: CollisionShape2D = $CollisionShape2D
@onready var normalPoint: Node2D = $NormalPoint

@export var color: Color = Color.WHITE :
	set(new_value):
		color = new_value
		if not is_node_ready():
			await ready
		self.colorRect.color = new_value


func _ready() -> void:
	SignalBus.ball_collided.connect(self._on_area_entered)


func get_normal() -> Vector2:
	return (self.normalPoint.global_position - self.global_position).normalized()


func _on_area_entered(ball: Ball, with: Object) -> void:
	if with != self:
		return
	self.hit_ball.emit(ball)
