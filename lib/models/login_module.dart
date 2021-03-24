class LoginResponseModel {
  final String token;
  final String error;
  final int id;
  final String name;

  LoginResponseModel({this.token, this.error, this.id, this.name});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        token: json["token"] != null ? json["token"] : "",
        error: json["error"] != null ? json["error"] : "",
        name: json["name"] != null ? json["name"] : "");
  }
}

class LoginRequestModel {
  String email;
  String password;

//Injecting constructor
  LoginRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
