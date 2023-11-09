extends Node
class_name HookController


@export_category("Hook Controller")
@export_group("Required Settings")
@export var hook_raycast: RayCast3D
@export var player_body: CharacterBody3D
@export var launch_action_name: String
@export var retract_action_name: String
@export_group("Optional Settings")
@export var pull_speed: float = 1
@export var hook_source: Node3D
@export_group("Advanced Settings")
@export var hook_scene: PackedScene = preload("res://addons/grappling_hook_3d/src/hook.tscn")

var _hook_model: Node3D
var _hook_target_normal: Vector3

var is_hook_launched: bool
var hook_target_position: Vector3

signal hook_launched()
signal hook_attached()
signal hook_detached()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(launch_action_name):
		hook_launched.emit()
		
		if not is_hook_launched and hook_raycast.is_colliding():
			_attach_hook()
		
		elif is_hook_launched:
			_retract_hook()
	
	if is_hook_launched:
		_handle_hook(delta)


func _attach_hook() -> void:
	is_hook_launched = true
	
	hook_target_position = hook_raycast.get_collision_point()
	_hook_target_normal = hook_raycast.get_collision_normal()
	
	_hook_model = hook_scene.instantiate()
	add_child(_hook_model)
	
	hook_attached.emit()


func _retract_hook() -> void:
	is_hook_launched = false
	
	_hook_model.queue_free()
	
	hook_detached.emit()


func _handle_hook(delta: float) -> void:
	# Hook pull math
	var pull_vector = (hook_target_position - player_body.global_position).normalized()
	
	player_body.velocity += pull_vector * pull_speed * delta * 60
	
	# Hook model
	var source_position: Vector3
	match true if hook_source else false:
		true: source_position = hook_source.global_position
		false: source_position = player_body.global_position
	
	_hook_model.extend_from_to(source_position, hook_target_position, _hook_target_normal)
