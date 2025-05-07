extends Node

func load_scene(incoming_scene_name: String, outgoing_scene_node: Node = null) -> void:
	var full_scene_path : String = "res://scenes/%s/%s.tscn" % [incoming_scene_name.to_lower(), incoming_scene_name]
	var incoming_packed_scene : PackedScene = load(full_scene_path)
	get_tree().root.add_child(incoming_packed_scene.instantiate())

	if outgoing_scene_node:
		outgoing_scene_node.queue_free()
