extends CharacterBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	#print("Hit")
	#print(body.name)
	queue_free()
	pass # Replace with function body.
