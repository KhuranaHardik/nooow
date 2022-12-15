class LoginResponse {
  String? token;
  int? statusCode;
  LoginResponse({this.token, this.statusCode});

  LoginResponse.fromJson(Map<String, dynamic> json, status) {
    token = json['token'];
    statusCode = status;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
