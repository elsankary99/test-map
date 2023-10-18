import 'geometry.dart';

class PlaceDetailsModel {
	Geometry? geometry;

	PlaceDetailsModel({this.geometry});

	factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
		return PlaceDetailsModel(
			geometry: json['geometry'] == null
						? null
						: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
		);
	}



	Map<String, dynamic> toJson() => {
				'geometry': geometry?.toJson(),
			};
}
