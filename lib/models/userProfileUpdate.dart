class UpdateProfile {
  String name;
  String email;
  String contactNo;

  UpdateProfile({this.name, this.email, this.contactNo});

  //Mapping the data
  Map<String, dynamic> toJson() => _$ModelToJson(this);

  _$ModelToJson(UpdateProfile userDetail) => <String, dynamic>{
        'name': userDetail.name,
        'email': userDetail.email,
        'contact_no': userDetail.contactNo
      };
}

class UpdateProfileResponse {
  final String error;
  final String message;
  final int success;

  UpdateProfileResponse({this.error, this.message, this.success});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      error: json["error"] != null ? json["error"] : "",
      message: json["message"] != null ? json["message"] : "",
      success: json["success"] != null ? json["success"] : "",
    );
  }
}
