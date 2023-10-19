class Distance {
	String? text;
	int? value;

	Distance({this.text, this.value});

	factory Distance.fromJson(Map<String, dynamic> json) => Distance(
				text: json['text'] as String?,
				value: json['value'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'text': text,
				'value': value,
			};
}
