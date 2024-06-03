class StringResponse {
  final String mes;

  StringResponse({required this.mes});

  factory StringResponse.formJson(Map<String, dynamic> json) {
    return StringResponse(mes: json['message']);
  }
}
