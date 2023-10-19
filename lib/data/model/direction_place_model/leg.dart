import 'distance.dart';
import 'duration.dart';
import 'end_location.dart';
import 'start_location.dart';
import 'step.dart';

class Leg {
	Distance? distance;
	Duration? duration;
	String? endAddress;
	EndLocation? endLocation;
	String? startAddress;
	StartLocation? startLocation;
	List<Step>? steps;
	List<dynamic>? trafficSpeedEntry;
	List<dynamic>? viaWaypoint;

	Leg({
		this.distance, 
		this.duration, 
		this.endAddress, 
		this.endLocation, 
		this.startAddress, 
		this.startLocation, 
		this.steps, 
		this.trafficSpeedEntry, 
		this.viaWaypoint, 
	});

	factory Leg.fromJson(Map<String, dynamic> json) => Leg(
				distance: json['distance'] == null
						? null
						: Distance.fromJson(json['distance'] as Map<String, dynamic>),
				duration: json['duration'] == null
						? null
						: Duration.fromJson(json['duration'] as Map<String, dynamic>),
				endAddress: json['end_address'] as String?,
				endLocation: json['end_location'] == null
						? null
						: EndLocation.fromJson(json['end_location'] as Map<String, dynamic>),
				startAddress: json['start_address'] as String?,
				startLocation: json['start_location'] == null
						? null
						: StartLocation.fromJson(json['start_location'] as Map<String, dynamic>),
				steps: (json['steps'] as List<dynamic>?)
						?.map((e) => Step.fromJson(e as Map<String, dynamic>))
						.toList(),
				trafficSpeedEntry: json['traffic_speed_entry'] as List<dynamic>?,
				viaWaypoint: json['via_waypoint'] as List<dynamic>?,
			);

	Map<String, dynamic> toJson() => {
				'distance': distance?.toJson(),
				'duration': duration?.toJson(),
				'end_address': endAddress,
				'end_location': endLocation?.toJson(),
				'start_address': startAddress,
				'start_location': startLocation?.toJson(),
				'steps': steps?.map((e) => e.toJson()).toList(),
				'traffic_speed_entry': trafficSpeedEntry,
				'via_waypoint': viaWaypoint,
			};
}
