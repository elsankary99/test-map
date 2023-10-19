import 'bounds.dart';
import 'leg.dart';
import 'overview_polyline.dart';

class DirectionPlaceModel {
	Bounds? bounds;
	String? copyrights;
	List<Leg>? legs;
	OverviewPolyline? overviewPolyline;
	String? summary;
	List<dynamic>? warnings;
	List<dynamic>? waypointOrder;

	DirectionPlaceModel({
		this.bounds, 
		this.copyrights, 
		this.legs, 
		this.overviewPolyline, 
		this.summary, 
		this.warnings, 
		this.waypointOrder, 
	});

	factory DirectionPlaceModel.fromJson(Map<String, dynamic> json) {
		return DirectionPlaceModel(
			bounds: json['bounds'] == null
						? null
						: Bounds.fromJson(json['bounds'] as Map<String, dynamic>),
			copyrights: json['copyrights'] as String?,
			legs: (json['legs'] as List<dynamic>?)
						?.map((e) => Leg.fromJson(e as Map<String, dynamic>))
						.toList(),
			overviewPolyline: json['overview_polyline'] == null
						? null
						: OverviewPolyline.fromJson(json['overview_polyline'] as Map<String, dynamic>),
			summary: json['summary'] as String?,
			warnings: json['warnings'] as List<dynamic>?,
			waypointOrder: json['waypoint_order'] as List<dynamic>?,
		);
	}



	Map<String, dynamic> toJson() => {
				'bounds': bounds?.toJson(),
				'copyrights': copyrights,
				'legs': legs?.map((e) => e.toJson()).toList(),
				'overview_polyline': overviewPolyline?.toJson(),
				'summary': summary,
				'warnings': warnings,
				'waypoint_order': waypointOrder,
			};
}
