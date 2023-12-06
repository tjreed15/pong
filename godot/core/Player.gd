@tool
class_name Player extends Node2D


@export var player_number: int = 1
@export var player_name: String = self.name


func get_normal() -> Vector2:
	return self.get_paddle().get_normal()


func get_paddle() -> Paddle:
	return self.__get_all_paddles()[0]


func _get_configuration_warnings() -> PackedStringArray:
	var paddle_count = self.__get_all_paddles().size()
	var goal_count = self.__get_all_goals().size()
	var ret = []
	if paddle_count != 1:
		ret.append("Must have exactly 1 child Paddle")
	if goal_count != 1:
		ret.append("Must have exactly 1 child PlayerGoal")
	return ret


func __get_all_paddles() -> Array[Paddle]:
	var arr = self.get_children().filter(func(child): return child is Paddle)
	var ret: Array[Paddle] = []
	ret.assign(arr)
	return ret
	
func __get_all_goals() -> Array[PlayerGoal]:
	var arr = self.get_children().filter(func(child): return child is PlayerGoal)
	var ret: Array[PlayerGoal] = []
	ret.assign(arr)
	return ret
