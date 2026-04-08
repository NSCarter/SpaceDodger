extends Node

@export var asteroid_scene: PackedScene
var score

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$AsteroidTimer.stop()
	
	$HUD.show_game_over()
	get_tree().call_group("asteroids", "queue_free")
	
func new_game():
	score = 0
	$Spaceship.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_AsteroidTimer_timeout():
	var asteroid = asteroid_scene.instantiate()
	var asteroid_spawn_location = $AsteroidPath/AsteroidSpawnLocation
	asteroid_spawn_location.progress_ratio = randf()
	asteroid.position = asteroid_spawn_location.position
	
	var velocity = Vector2(0.0, randf_range(150.0, 250.0))
	asteroid.linear_velocity = velocity
	
	add_child(asteroid)

func _on_ScoreTimer_timeout():
	score += 1
	
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$AsteroidTimer.start()
	$ScoreTimer.start()
