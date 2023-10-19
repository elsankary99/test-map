class EndLocation {
	double? lat;
	double? lng;

	EndLocation({this.lat, this.lng});

	factory EndLocation.fromJson(Map<String, dynamic> json) => EndLocation(
				lat: (json['lat'] as num?)?.toDouble(),
				lng: (json['lng'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'lat': lat,
				'lng': lng,
			};
}
