class_name MathUtils extends Node

static func average(arr: Array[float]) -> float:
	var sum = arr.reduce(func(val, acc): return val+acc)
	return sum / arr.size()
