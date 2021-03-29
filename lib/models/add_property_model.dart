class AddProperty {
  String property_name;
  String property_description;
  String property_price;
  String property_status;
  String property_type;
  String property_address;
  String property_city;
  String property_located_area;
  String built_up_area;
  String property_total_area;
  String property_face;
  String road_distance;
  String road_type;
  String bedroom;
  String rooms;
  String kitchen;
  String living_room;
  String parking;
  String built_year;
  String total_floors;
  String bathroom;

//Creating constructor for all the declared variables
  AddProperty({
    this.property_name,
    this.property_description,
    this.property_price,
    this.property_status,
    this.property_type,
    this.property_address,
    this.property_city,
    this.property_located_area,
    this.built_up_area,
    this.property_total_area,
    this.property_face,
    this.road_distance,
    this.road_type,
    this.bathroom,
    this.rooms,
    this.kitchen,
    this.living_room,
    this.parking,
    this.built_year,
    this.total_floors,
    this.bedroom,
  });

  //Mapping the data in the form of JSON
  Map<String, dynamic> toJson() => _$ModelToJson(this);

  _$ModelToJson(AddProperty instance) => <String, dynamic>{
        'property_name': instance.property_name,
        'property_description': instance.property_description,
        'property_price': instance.property_price,
        'property_status': instance.property_status,
        'property_type': instance.property_type,
        'property_address': instance.property_address,
        'property_city': instance.property_city,
        'property_located_area': instance.property_located_area,
        'built_up_area': instance.built_up_area,
        'property_total_area': instance.property_total_area,
        'property_face': instance.property_face,
        'road_distance': instance.road_distance,
        'road_type': instance.road_type,
        'bathroom': instance.bathroom,
        'rooms': instance.rooms,
        'kitchen': instance.kitchen,
        'living_room': instance.living_room,
        'parking': instance.parking,
        'built_year': instance.built_year,
        'total_floors': instance.total_floors,
        'bedroom': instance.bedroom,
      };
}

class AddPropertyResponse {
  final String error;
  final String message;
  final int propertyid;
  final int success;

  AddPropertyResponse(
      {this.error, this.message, this.propertyid, this.success});

  factory AddPropertyResponse.fromJson(Map<String, dynamic> json) {
    return AddPropertyResponse(
        message: json["message"] != null ? json["message"] : "",
        error: json["error"] != null ? json["error"] : "",
        propertyid: json["propertyid"] != null ? json["propertyid"] : "",
        success: json["success"] != null ? json["success"] : "");
  }
}
