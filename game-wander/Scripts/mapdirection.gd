# Code links the map tiles to each other. - Allows the game to run smoothly compared to one big map.

extends Node2D

@export_file("*.tscn") var top: String
@export_file("*.tscn") var bottom: String
@export_file("*.tscn") var left: String
@export_file("*.tscn") var right: String
