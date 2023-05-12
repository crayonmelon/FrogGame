extends Camera3D

@onready var car_cam = $"../CarView/CarCam"
@export var pos_offset = Vector3(10,10,10)

var camera_follow
var desired_pos

func _process(delta):
	
	var points = get_tree().get_nodes_in_group("CameraTrack")
	if points.size() == 0:
		return
	
	set_camera_pos(points, delta)
	set_camera_scale(points, delta)
	
func set_camera_pos(points, delta):
	
	var camera_pos = mid_point(points) + pos_offset
	
	var diff_x = camera_pos.x - global_position.x 
	var diff_z = camera_pos.z - global_position.z 
	
	global_position.x = lerp(global_position.x, camera_pos.x, .01)
	global_position.z = lerp(global_position.z, camera_pos.z, .01)
	
	car_cam.global_position.x = lerp(global_position.x, camera_pos.x , .01)
	car_cam.global_position.z = lerp (global_position.z, camera_pos.z, .01)

func mid_point(points):
	
	if points.size() == 0:
		return
	
	var x_vals = 0 
	var z_vals = 0
	
	for point in points:
		x_vals += point.global_position.x
		z_vals += point.global_position.z
		
	return Vector3((x_vals/points.size()), 0,(z_vals/points.size()))
	
func set_camera_scale(points, delta):
	
	var scale = 20
	var furthest_distance = 0
	
	for point in points:
		var x_dis = abs(position.x - point.global_position.x) 
		var z_dis = abs(position.z - point.global_position.z)
		
		if x_dis > furthest_distance || z_dis > furthest_distance:
			furthest_distance = x_dis if x_dis > z_dis else z_dis
	
	scale = (furthest_distance)*2
	
	var diff = size - scale
	
	size = lerp(size, scale, .01)
	car_cam.size = lerp(size, scale, .01)
