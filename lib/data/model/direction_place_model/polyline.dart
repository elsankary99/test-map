class Polyline {
	String? points;

	Polyline({this.points});

	factory Polyline.fromJson(Map<String, dynamic> json) => Polyline(
				points: json['points'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'points': points,
			};
}
