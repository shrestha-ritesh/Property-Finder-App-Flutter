// To parse this JSON data, do
//
//     final property = propertyFromJson(jsonString);

import 'dart:convert';

Property propertyFromJson(String str) => Property.fromJson(json.decode(str));

String propertyToJson(Property data) => json.encode(data.toJson());

class Property {
  Property({
    this.success,
    this.data,
  });

  int success;
  List<Datum> data;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
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
    this.longitude,
    this.latitude,
    this.images,
    this.otherDetails,
    this.userDetail,
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
  String longitude;
  String latitude;
  List<String> images;
  OtherDetails otherDetails;
  UserDetail userDetail;

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
        longitude: json["longitude"],
        latitude: json["latitude"],
        images: List<String>.from(json["images"].map((x) => x)),
        otherDetails: json["other_details"] == null
            ? null
            : OtherDetails.fromJson(json["other_details"]),
        userDetail: UserDetail.fromJson(json["user_detail"]),
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
        "longitude": longitude,
        "latitude": latitude,
        "images": List<dynamic>.from(images.map((x) => x)),
        "other_details": otherDetails == null ? null : otherDetails.toJson(),
        "user_detail": userDetail.toJson(),
      };
}

class OtherDetails {
  OtherDetails({
    this.houseId,
    this.bedroom,
    this.rooms,
    this.kitchen,
    this.livingRoom,
    this.parking,
    this.propertyId,
    this.builtYear,
    this.totalFloors,
    this.apartmentId,
    this.bathroom,
  });

  int houseId;
  String bedroom;
  String rooms;
  String kitchen;
  String livingRoom;
  String parking;
  int propertyId;
  String builtYear;
  String totalFloors;
  int apartmentId;
  String bathroom;

  factory OtherDetails.fromJson(Map<String, dynamic> json) => OtherDetails(
        houseId: json["house_id"] == null ? null : json["house_id"],
        bedroom: json["bedroom"],
        rooms: json["rooms"],
        kitchen: json["kitchen"],
        livingRoom: json["living_room"],
        parking: json["parking"],
        propertyId: json["property_id"],
        builtYear: json["built_year"] == null ? null : json["built_year"],
        totalFloors: json["total_floors"] == null ? null : json["total_floors"],
        apartmentId: json["apartment_id"] == null ? null : json["apartment_id"],
        bathroom: json["bathroom"] == null ? null : json["bathroom"],
      );

  Map<String, dynamic> toJson() => {
        "house_id": houseId == null ? null : houseId,
        "bedroom": bedroom,
        "rooms": rooms,
        "kitchen": kitchen,
        "living_room": livingRoom,
        "parking": parking,
        "property_id": propertyId,
        "built_year": builtYear == null ? null : builtYear,
        "total_floors": totalFloors == null ? null : totalFloors,
        "apartment_id": apartmentId == null ? null : apartmentId,
        "bathroom": bathroom == null ? null : bathroom,
      };
}

class UserDetail {
  UserDetail({
    this.userId,
    this.name,
    this.email,
    this.contactNo,
  });

  int userId;
  String name;
  String email;
  String contactNo;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        contactNo: json["contact_no"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "contact_no": contactNo,
      };
}
