class FavouriteSave {
  String userId;
  String property_id;

  FavouriteSave({
    this.userId,
    this.property_id,
  });

  //Mapping the data in the form of JSON
  Map<String, dynamic> toJson() => _$ModelToJson(this);

  _$ModelToJson(FavouriteSave instance) => <String, dynamic>{
        'userId': instance.userId,
        'property_id': instance.property_id
      };
}

class FavouriteSaveResponse {
  final String error;
  final String message;
  final int success;

  FavouriteSaveResponse({this.error, this.message, this.success});

  factory FavouriteSaveResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteSaveResponse(
      error: json["error"] != null ? json["error"] : "",
      message: json["message"] != null ? json["message"] : "",
      success: json["success"] != null ? json["success"] : "",
    );
  }
}
