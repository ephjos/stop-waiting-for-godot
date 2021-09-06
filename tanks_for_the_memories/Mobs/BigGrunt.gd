extends KinematicBody2D

const Bullet = preload("res://Bullet/RedBullet.tscn")

var health = 15
var player 
export var move_speed : = 20
export var rotation_speed : = 1 / 5.0
var heading = Vector2() # the direction the tank is pointing

var shootTimer
var shootDelay = 1.250
var canShoot = true
var barrel1 = true

func _ready():
	shootTimer = Timer.new()
	shootTimer.one_shot = true
	shootTimer.wait_time = shootDelay
	shootTimer.connect("timeout", self, "_shoot_timeout")
	add_child(shootTimer)
	
func _shoot_timeout():
	canShoot = true
	
func _physics_process(delta: float) -> void:
	if !is_instance_valid(player):
		rotation_degrees += 10
		return
		
	# Look at player
	heading = position.direction_to(player.position).normalized()
	rotation = heading.angle()
	
	# Drive towards player
	move_and_slide(heading * move_speed, Vector2())
	
	# TODO: animate tire tracks
	
	if canShoot:		
		shoot()
		canShoot = false
		shootTimer.start()

func shoot():
	# TODO: animate muzzle flash
	var b = Bullet.instance()
	owner.add_child(b)
	
	if barrel1:
		b.transform = $Barrel1.global_transform
	else:
		b.transform = $Barrel2.global_transform
	
	barrel1 = !barrel1
		

func hit():
	# TODO: animate hit
	
	health -= 1
	if health <= 0:
		queue_free()


	
