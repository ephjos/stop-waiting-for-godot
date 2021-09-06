extends KinematicBody2D

const Bullet = preload("res://Bullet/RedBullet.tscn")

var player 
export var rotation_speed : = 1 / 10.0
var heading = Vector2() # the direction the tank is pointing

var shootTimer
var shootDelay = 0.750
var canShoot = true

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
	
	if canShoot:		
		shoot()
		canShoot = false
		shootTimer.start()

func shoot():
	# TODO: animate muzzle flash
	var b = Bullet.instance()
	owner.add_child(b)
	b.transform = $Barrel.global_transform

func hit():
	# TODO: animate hit
	queue_free()

	
