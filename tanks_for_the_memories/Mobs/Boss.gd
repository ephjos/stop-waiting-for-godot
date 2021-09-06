extends KinematicBody2D

const Bullet = preload("res://Bullet/DarkBullet.tscn")

var health = 200
var player 
export var move_speed : = 5.0
export var rotation_speed : = 1 / 50.0
var heading = Vector2() # the direction the tank is pointing

var shootTimer
var shootDelay = 4.000
var canShoot = true
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
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
	
	var barrels = [$Barrel1, $Barrel2, $Barrel3]
	var flashes = [$Flash1, $Flash2, $Flash3]
	
	for i in 32:
		for barrel in 3:
			var flip = rng.randf_range(0,1)
			if flip > 0.4:	
				var b = Bullet.instance()
				owner.add_child(b)
				b.transform = barrels[barrel].global_transform
				flashes[barrel].play()
		yield(get_tree().create_timer(rng.randf_range(0.005,0.05)), "timeout")
	
	shootTimer.wait_time = rng.randf_range(1.5,8)

func hit():
	# TODO: animate hit
	
	health -= 1
	if health <= 0:
		queue_free()

func _on_Flash1_animation_finished():
	$Flash1.stop()
	$Flash1.frame = 0

func _on_Flash2_animation_finished():
	$Flash2.stop()
	$Flash2.frame = 0

func _on_Flash3_animation_finished():
	$Flash3.stop()
	$Flash3.frame = 0
