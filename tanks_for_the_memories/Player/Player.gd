extends KinematicBody2D

const BlueBullet = preload("res://Bullet/BlueBullet.tscn")

signal hit
signal dead

export var health = 30 # 15
export var move_speed : = 250.0
export var rotation_speed : = 1 / 15.0
var heading = Vector2() # the direction the tank is pointing

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	var throttle : = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	
	rotation += (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * rotation_speed
	heading = Vector2(cos(rotation), sin(rotation)).normalized()
	
	move_and_slide(heading * throttle * move_speed, Vector2())
	# TODO: animate tire tracks
	
	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func shoot():	
	var b = BlueBullet.instance()
	owner.add_child(b)
	b.transform = $Barrel.global_transform
	$Flash.play()

func hit():
	# TODO: animate hit
	
	health -= 1
	emit_signal("hit", health)
	if health <= 0:
		emit_signal("dead")
		queue_free()

func _on_Flash_animation_finished():
	$Flash.stop()
	$Flash.frame = 0
