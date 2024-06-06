class StringResponse {
  final String data;

  StringResponse({required this.data});

  factory StringResponse.formJson(String json) {
    return StringResponse(data: json);
  }
}
