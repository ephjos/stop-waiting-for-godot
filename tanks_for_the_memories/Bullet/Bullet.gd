extends Area2D

const Hit : PackedScene = preload("res://Bullet/Hit.tscn")
const ShotSound : PackedScene = preload("res://Bullet/ShotSound.tscn")
const HitSound : PackedScene = preload("res://Bullet/HitSound.tscn")

var speed = 600

func _ready():
	add_to_group("bullets")
	var shot = ShotSound.instance()
	shot.position = position
	shot.play()
	shot.volume_db = -15
	add_child(shot)

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
	
	var shot = HitSound.instance()
	shot.position = position
	shot.play()
	shot.volume_db = -20
	add_child(shot)
	
	hit.play()
	
	yield(hit, "animation_finished")
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
