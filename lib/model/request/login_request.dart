class EmailLoginRequest {
  String email, password;
  EmailLoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
