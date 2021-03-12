class RegisterResponse {
  final String message;
  final String error;

  RegisterResponse({
    this.message,
    this.error,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
        message: json["message"] != null ? json["message"] : "",
        error: json["error"] != null ? json["error"] : "");
  }
}

class RegisterRequestModel {
  String name;
  String email;
  String password;
  String passwordConfirm;
  String contact_no;

  RegisterRequestModel({
    this.name,
    this.email,
    this.password,
    this.passwordConfirm,
    this.contact_no,
  });

  //Maping the requested data:
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'passwordConfirm': passwordConfirm.trim(),
      'contact_no': contact_no,
    };

    return map;
  }
}
