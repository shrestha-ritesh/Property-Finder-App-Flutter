class AddProperty {
  // ignore: non_constant_identifier_names
  String property_name;
  // ignore: non_constant_identifier_names
  String property_description;
  // ignore: non_constant_identifier_names
  String property_price;
  // ignore: non_constant_identifier_names
  String property_status;
  String property_type;
  // ignore: non_constant_identifier_names
  String property_address;
  // ignore: non_constant_identifier_names
  String property_city;
  // ignore: non_constant_identifier_names
  String property_located_area;
  // ignore: non_constant_identifier_names
  String built_up_area;
  // ignore: non_constant_identifier_names
  String property_total_area;
  // ignore: non_constant_identifier_names
  String property_face;
  // ignore: non_constant_identifier_names
  String road_distance;
  // ignore: non_constant_identifier_names
  String road_type;
  // ignore: non_constant_identifier_names
  String bedroom;
  String rooms;
  String kitchen;
  // ignore: non_constant_identifier_names
  String living_room;
  String parking;
  // ignore: non_constant_identifier_names
  String built_year;
  // ignore: non_constant_identifier_names
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
