extends Node2D

onready var GrassEffect = load("res://Effects/GrassEffect.tscn")
onready var main = get_tree().current_scene

func _process(delta):
		if Input.is_action_pressed("ui_select"):
			var grassEffect = GrassEffect.instance()
			main.add_child(grassEffect)
			grassEffect.global_position = self.global_position
			queue_free()
