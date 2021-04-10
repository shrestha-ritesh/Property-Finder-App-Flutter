class UserRequest {
  String siteInspection;
  String ratesAndPrice;
  String propertyDetails;
  String similarProperty;
  String inspectionRequestDesc;
  String reqUserName;
  String reqUserEmail;
  String reqUserContact;
  String selectedInspectionDate;

  //Creating constructor and injecting
  UserRequest({
    this.siteInspection,
    this.ratesAndPrice,
    this.propertyDetails,
    this.similarProperty,
    this.inspectionRequestDesc,
    this.reqUserName,
    this.reqUserContact,
    this.reqUserEmail,
    this.selectedInspectionDate,
  });

  //Mapping the data in the form of JSON
  Map<String, dynamic> toJson() => _$ModelToJson(this);

  //MAPPING THE user filled data in Json:
  _$ModelToJson(UserRequest instance) => <String, dynamic>{
        'siteInspection': instance.siteInspection,
        'ratesAndPrice': instance.ratesAndPrice,
        'propertyDetails': instance.propertyDetails,
        'similarProperty': instance.similarProperty,
        'inspectionRequestDesc': instance.inspectionRequestDesc,
        'reqUserName': instance.reqUserName,
        'reqEmail': instance.reqUserEmail,
        'reqContact': instance.reqUserContact,
        'selectedInspectionDate': instance.selectedInspectionDate
      };
}

class UserRequestResponse {
  final String error;
  final String message;

  UserRequestResponse({
    this.error,
    this.message,
  });

  factory UserRequestResponse.fromJson(Map<String, dynamic> json) {
    return UserRequestResponse(
      error: json["error"] != null ? json["error"] : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}
