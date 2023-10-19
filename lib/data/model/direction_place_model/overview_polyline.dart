class OverviewPolyline {
	String? points;

	OverviewPolyline({this.points});

	factory OverviewPolyline.fromJson(Map<String, dynamic> json) {
		return OverviewPolyline(
			points: json['points'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'points': points,
			};
}
