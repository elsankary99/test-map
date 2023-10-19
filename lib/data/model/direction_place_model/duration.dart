class Duration {
	String? text;
	int? value;

	Duration({this.text, this.value});

	factory Duration.fromJson(Map<String, dynamic> json) => Duration(
				text: json['text'] as String?,
				value: json['value'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'text': text,
				'value': value,
			};
}
