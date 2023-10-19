import 'distance.dart';
import 'duration.dart';
import 'end_location.dart';
import 'polyline.dart';
import 'start_location.dart';

class Step {
	Distance? distance;
	Duration? duration;
	EndLocation? endLocation;
	String? htmlInstructions;
	Polyline? polyline;
	StartLocation? startLocation;
	String? travelMode;
	String? maneuver;

	Step({
		this.distance, 
		this.duration, 
		this.endLocation, 
		this.htmlInstructions, 
		this.polyline, 
		this.startLocation, 
		this.travelMode, 
		this.maneuver, 
	});

	factory Step.fromJson(Map<String, dynamic> json) => Step(
				distance: json['distance'] == null
						? null
						: Distance.fromJson(json['distance'] as Map<String, dynamic>),
				duration: json['duration'] == null
						? null
						: Duration.fromJson(json['duration'] as Map<String, dynamic>),
				endLocation: json['end_location'] == null
						? null
						: EndLocation.fromJson(json['end_location'] as Map<String, dynamic>),
				htmlInstructions: json['html_instructions'] as String?,
				polyline: json['polyline'] == null
						? null
						: Polyline.fromJson(json['polyline'] as Map<String, dynamic>),
				startLocation: json['start_location'] == null
						? null
						: StartLocation.fromJson(json['start_location'] as Map<String, dynamic>),
				travelMode: json['travel_mode'] as String?,
				maneuver: json['maneuver'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'distance': distance?.toJson(),
				'duration': duration?.toJson(),
				'end_location': endLocation?.toJson(),
				'html_instructions': htmlInstructions,
				'polyline': polyline?.toJson(),
				'start_location': startLocation?.toJson(),
				'travel_mode': travelMode,
				'maneuver': maneuver,
			};
}
