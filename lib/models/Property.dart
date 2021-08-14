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
    this.longitude,
    this.latitude,
    this.status,
    this.images,
    this.userDetail,
    this.otherDetails,
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
  String longitude;
  String latitude;
  String status;
  List<String> images;
  UserDetail userDetail;
  OtherDetails otherDetails;

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
        longitude: json["longitude"],
        latitude: json["latitude"],
        status: json["status"],
        images: List<String>.from(json["images"].map((x) => x)),
        userDetail: UserDetail.fromJson(json["user_detail"]),
        otherDetails: json["other_details"] == null
            ? null
            : OtherDetails.fromJson(json["other_details"]),
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
        "longitude": longitude,
        "latitude": latitude,
        "status": status,
        "images": List<dynamic>.from(images.map((x) => x)),
        "user_detail": userDetail.toJson(),
        "other_details": otherDetails == null ? null : otherDetails.toJson(),
      };
}

class OtherDetails {
  OtherDetails({
    this.apartmentId,
    this.bedroom,
    this.rooms,
    this.kitchen,
    this.livingRoom,
    this.bathroom,
    this.parking,
    this.propertyId,
    this.houseId,
    this.builtYear,
    this.totalFloors,
  });

  int apartmentId;
  String bedroom;
  String rooms;
  String kitchen;
  String livingRoom;
  String bathroom;
  String parking;
  int propertyId;
  int houseId;
  String builtYear;
  String totalFloors;

  factory OtherDetails.fromJson(Map<String, dynamic> json) => OtherDetails(
        apartmentId: json["apartment_id"] == null ? null : json["apartment_id"],
        bedroom: json["bedroom"],
        rooms: json["rooms"],
        kitchen: json["kitchen"],
        livingRoom: json["living_room"],
        bathroom: json["bathroom"] == null ? null : json["bathroom"],
        parking: json["parking"],
        propertyId: json["property_id"],
        houseId: json["house_id"] == null ? null : json["house_id"],
        builtYear: json["built_year"] == null ? null : json["built_year"],
        totalFloors: json["total_floors"] == null ? null : json["total_floors"],
      );

  Map<String, dynamic> toJson() => {
        "apartment_id": apartmentId == null ? null : apartmentId,
        "bedroom": bedroom,
        "rooms": rooms,
        "kitchen": kitchen,
        "living_room": livingRoom,
        "bathroom": bathroom == null ? null : bathroom,
        "parking": parking,
        "property_id": propertyId,
        "house_id": houseId == null ? null : houseId,
        "built_year": builtYear == null ? null : builtYear,
        "total_floors": totalFloors == null ? null : totalFloors,
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
