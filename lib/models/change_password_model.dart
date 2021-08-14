class ChangePasswordRequest {
  String oldPassword;
  String newPassword;

  //Creating the constructor for the model:
  ChangePasswordRequest({this.oldPassword, this.newPassword});

  //Mapping the data in the form of JSON
  Map<String, dynamic> toJson() => _$ModelToJson(this);

  //MAPPING THE user filled data in Json:
  _$ModelToJson(ChangePasswordRequest instance) => <String, dynamic>{
        'oldPassword': instance.oldPassword,
        'newPassword': instance.newPassword,
      };
}

class ChangePasswordResponse {
  final String error;
  final String message;
  final int success;

  ChangePasswordResponse({this.error, this.message, this.success});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      error: json["error"] != null ? json["error"] : "",
      message: json["message"] != null ? json["message"] : "",
      success: json["success"] != null ? json["success"] : "",
    );
  }
}
