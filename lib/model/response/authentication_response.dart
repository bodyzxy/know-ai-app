class AuthenticationResponse {
  final String accessToken;
  final String refreshToken;

  AuthenticationResponse(
      {required this.accessToken, required this.refreshToken});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(
        accessToken: json['accessToken'], refreshToken: json['refreshToken']);
  }
}
