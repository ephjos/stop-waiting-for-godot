extends KinematicBody2D

const Bullet = preload("res://Bullet/DarkBullet.tscn")

var player 
export var move_speed : = 25.0
export var rotation_speed : = 1 / 15.0
var heading = Vector2() # the direction the tank is pointing

var shootTimer
var shootDelay = 1.000
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
	b.transform = $Barrel.global_transform
	$Flash.play()

func hit():
	# TODO: animate hit
	queue_free()

func _on_Flash_animation_finished():
	$Flash.stop()
	$Flash.frame = 0
