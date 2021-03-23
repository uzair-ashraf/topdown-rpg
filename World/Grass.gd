extends Node2D

onready var GrassEffect = load("res://Effects/GrassEffect.tscn")
onready var main = get_tree().current_scene

func _on_HurtBox_area_entered(area):
		triggerGrassEffect()
		queue_free()

func triggerGrassEffect():
	var grassEffect = GrassEffect.instance()
	main.add_child(grassEffect)
	grassEffect.global_position = self.global_position
