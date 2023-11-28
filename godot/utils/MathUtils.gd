class_name MathUtils extends Node

const N_BUCKETS = 6

static func average(arr: Array[float]) -> float:
	var sum = arr.reduce(func(val, acc): return val+acc)
	return sum / arr.size()
	
	
static func clamp(vector: Vector2, max_size: float, min_size: float = 0.0) -> Vector2:
	var size = vector.length()
	return vector.normalized() * clampf(size, min_size, max_size)
