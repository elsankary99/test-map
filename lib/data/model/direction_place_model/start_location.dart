class StartLocation {
	double? lat;
	double? lng;

	StartLocation({this.lat, this.lng});

	factory StartLocation.fromJson(Map<String, dynamic> json) => StartLocation(
				lat: (json['lat'] as num?)?.toDouble(),
				lng: (json['lng'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'lat': lat,
				'lng': lng,
			};
}
