// To parse this JSON data, do
//
//     final property = propertyFromJson(jsonString);

import 'dart:convert';

Property propertyFromJson(String str) => Property.fromJson(json.decode(str));

String propertyToJson(Property data) => json.encode(data.toJson());

class Property {
  Property({
    this.data,
  });

  List<Datum> data;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.propertyId,
    this.propertyName,
    this.propertyDescription,
    this.propertyPrice,
    this.propertyStatus,
    this.propertyType,
    this.propertyAddress,
    this.propertyCity,
    this.propertyLocatedArea,
    this.builtUpArea,
    this.propertyTotalArea,
    this.propertyFace,
    this.roadDistance,
    this.roadType,
    this.propertyAddedDate,
    this.userId,
    this.thumbnailImage,
    this.images,
  });

  int propertyId;
  String propertyName;
  String propertyDescription;
  int propertyPrice;
  String propertyStatus;
  String propertyType;
  String propertyAddress;
  String propertyCity;
  String propertyLocatedArea;
  String builtUpArea;
  String propertyTotalArea;
  String propertyFace;
  String roadDistance;
  String roadType;
  DateTime propertyAddedDate;
  int userId;
  String thumbnailImage;
  List<String> images;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        propertyId: json["property_id"],
        propertyName: json["property_name"],
        propertyDescription: json["property_description"],
        propertyPrice: json["property_price"],
        propertyStatus: json["property_status"],
        propertyType: json["property_type"],
        propertyAddress: json["property_address"],
        propertyCity: json["property_city"],
        propertyLocatedArea: json["property_located_area"],
        builtUpArea: json["built_up_area"],
        propertyTotalArea: json["property_total_area"],
        propertyFace: json["property_face"],
        roadDistance: json["road_distance"],
        roadType: json["road_type"],
        propertyAddedDate: DateTime.parse(json["property_added_date"]),
        userId: json["userId"],
        thumbnailImage: json["thumbnail_image"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "property_id": propertyId,
        "property_name": propertyName,
        "property_description": propertyDescription,
        "property_price": propertyPrice,
        "property_status": propertyStatus,
        "property_type": propertyType,
        "property_address": propertyAddress,
        "property_city": propertyCity,
        "property_located_area": propertyLocatedArea,
        "built_up_area": builtUpArea,
        "property_total_area": propertyTotalArea,
        "property_face": propertyFace,
        "road_distance": roadDistance,
        "road_type": roadType,
        "property_added_date": propertyAddedDate.toIso8601String(),
        "userId": userId,
        "thumbnail_image": thumbnailImage,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
