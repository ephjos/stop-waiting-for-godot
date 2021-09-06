extends Area2D

const Hit : PackedScene = preload("res://Bullet/Hit.tscn")

var speed = 600

func _ready():
	add_to_group("bullets")

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs") or body.is_in_group("player") or body.is_in_group("obstacle"):
		body.hit()
		
	if body.is_in_group("low_obstacle"):
		return
		
	set_physics_process(false)
	var hit = Hit.instance()
	add_child(hit)
	hit.play()
	
	yield(hit, "animation_finished")
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
