extends Camera3D

@onready var car_cam = $"../CarView/CarCam"
@export var pos_offset = Vector3(10,10,10)

var camera_follow

func _process(delta):
	
	var points = get_tree().get_nodes_in_group("CameraTrack")
	if points.size() == 0:
		return
	
	set_camera_pos(points)
	set_camera_scale(points)
	
func set_camera_pos(points):
	
	
	var camera_pos = mid_point(points)
	
	global_position.x = camera_pos.x + pos_offset.x
	global_position.z = camera_pos.z + pos_offset.z
	
	car_cam.global_position.x = camera_pos.x + pos_offset.x
	car_cam.global_position.z = camera_pos.z + pos_offset.z

func mid_point(points):
	
	if points.size() == 0:
		return
	
	var x_vals = 0 
	var z_vals = 0
	
	for point in points:
		x_vals += point.global_position.x
		z_vals += point.global_position.z
		
	return Vector3((x_vals/points.size()), 0,(z_vals/points.size()))
	
func set_camera_scale(points):
	var scale = 20

	var furthest_distance = 0
	
	for point in points:
		var x_dis = abs(position.x - point.global_position.x) 
		var z_dis = abs(position.z - point.global_position.z)
		
		if x_dis > furthest_distance || z_dis > furthest_distance:
			furthest_distance = x_dis if x_dis > z_dis else z_dis
	
	scale = (furthest_distance)*2
	
	size = scale
	car_cam.size = scale
