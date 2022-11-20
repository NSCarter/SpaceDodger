extends Node

export (PackedScene) var planet_scene
var score

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$PlanetTimer.stop()
	
func new_game():
	score = 0
	$Spaceship.start($StartPosition.position)
	$StartTimer.start()

func _on_PlanetTimer_timeout():
	var planet = planet_scene.instance()
	var planet_spawn_location = get_node("PlanetPath/PlanetSpawnLocation")
	planet_spawn_location.offset = randi()
	planet.position = planet_spawn_location.position
	
	var velocity = Vector2(0.0, rand_range(150.0, 250.0))
	planet.linear_velocity = velocity
	
	add_child(planet)

func _on_ScoreTimer_timeout():
	score += 1

func _on_StartTimer_timeout():
	$PlanetTimer.start()
	$ScoreTimer.start()
