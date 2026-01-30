extends Node

@export var planet_scene: PackedScene
var score

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$PlanetTimer.stop()
	
	$HUD.show_game_over()
	get_tree().call_group("planets", "queue_free")
	
func new_game():
	score = 0
	$Spaceship.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_PlanetTimer_timeout():
	var planet = planet_scene.instantiate()
	var planet_spawn_location = $PlanetPath/PlanetSpawnLocation
	planet_spawn_location.progress_ratio = randf()
	planet.position = planet_spawn_location.position
	
	var velocity = Vector2(0.0, randf_range(150.0, 250.0))
	planet.linear_velocity = velocity
	
	add_child(planet)

func _on_ScoreTimer_timeout():
	score += 1
	
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$PlanetTimer.start()
	$ScoreTimer.start()
