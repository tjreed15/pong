extends Node2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var paddle1: Paddle = $Paddle1
@onready var paddle2: Paddle = $Paddle2
@onready var paddle3: Paddle = $Paddle3
@onready var paddle4: Paddle = $Paddle4
var timer: Timer

@export var speed: int = 300
@export var time: float = 0.5

@export var color: Color :
	set(new_value):
		color = new_value
		if not is_node_ready():
			await ready
		self.paddle1.color = new_value
		self.paddle2.color = new_value
		self.paddle3.color = new_value
		self.paddle4.color = new_value

@export var size: Vector2 :
	set(new_value):
		size = new_value
		if not is_node_ready():
			await ready
		self.paddle1.color_rect.size = new_value / 2
		self.paddle2.color_rect.size = new_value / 2
		self.paddle3.color_rect.size = new_value / 2
		self.paddle4.color_rect.size = new_value / 2

func _ready() -> void:
	if DataStore.global_settings.sfx_enabled:
		self.audio_player.play()
	self.timer = Timer.new()
	add_child(self.timer)
	self.timer.one_shot = true
	self.timer.start(self.time)
	self.timer.timeout.connect(self.__on_timer_end)

func _process(delta: float) -> void:
	if not self.timer.is_stopped():
		self.paddle1.position += Vector2(1, -1).normalized() * self.speed * delta
		self.paddle2.position += Vector2(-1, -1).normalized() * self.speed * delta
		self.paddle3.position += Vector2(1, 1).normalized() * self.speed * delta
		self.paddle4.position += Vector2(-1, 1).normalized() * self.speed * delta

func __on_timer_end() -> void:
	self.paddle1.queue_free()
	self.paddle2.queue_free()
	self.paddle3.queue_free()
	self.paddle4.queue_free()
