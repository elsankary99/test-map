import 'northeast.dart';
import 'southwest.dart';

class Bounds {
	Northeast? northeast;
	Southwest? southwest;

	Bounds({this.northeast, this.southwest});

	factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
				northeast: json['northeast'] == null
						? null
						: Northeast.fromJson(json['northeast'] as Map<String, dynamic>),
				southwest: json['southwest'] == null
						? null
						: Southwest.fromJson(json['southwest'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'northeast': northeast?.toJson(),
				'southwest': southwest?.toJson(),
			};
}
