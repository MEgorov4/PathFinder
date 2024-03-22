class_name PriorityQueue
extends RefCounted

var queue = []

func push(item, priority: int):
	queue.append({"item": item, "priority": priority})
	queue.sort_custom(func(a, b): return a["priority"] < b["priority"])

func pop() -> Variant:
	if queue.size() > 0:
		return queue.pop_front()["item"]
	return null
	
func is_empty() -> bool:
	return queue.size() == 0
