class ReportRequest {
  String reportTitle;
  String titleDescription;

  //Creating the constructor
  ReportRequest({this.reportTitle, this.titleDescription});

  //Mapping the user data in the form of JSON
  Map<String, dynamic> toJson() => _$ModelToJson(this);

  _$ModelToJson(ReportRequest instance) => <String, dynamic>{
        'reportTitle': instance.reportTitle,
        'titleDescription': instance.titleDescription
      };
}

class ReportResponse {
  final String error;
  final String message;
  final int success;

  ReportResponse({this.error, this.message, this.success});

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      error: json["error"] != null ? json["error"] : "",
      message: json["message"] != null ? json["message"] : "",
      success: json["success"] != null ? json["success"] : "",
    );
  }
}
