// To parse this JSON data, do
//
//     final favouritesData = favouritesDataFromJson(jsonString);

import 'dart:convert';

FavouritesData favouritesDataFromJson(String str) =>
    FavouritesData.fromJson(json.decode(str));

String favouritesDataToJson(FavouritesData data) => json.encode(data.toJson());

class FavouritesData {
  FavouritesData({
    this.data,
  });

  List<FavouritesId> data;

  factory FavouritesData.fromJson(Map<String, dynamic> json) => FavouritesData(
        data: List<FavouritesId>.from(
            json["data"].map((x) => FavouritesId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FavouritesId {
  FavouritesId({
    this.favouriteId,
    this.userId,
    this.propertyId,
    this.savedPropertyDate,
  });

  int favouriteId;
  int userId;
  int propertyId;
  DateTime savedPropertyDate;

  factory FavouritesId.fromJson(Map<String, dynamic> json) => FavouritesId(
        favouriteId: json["favourite_id"],
        userId: json["userId"],
        propertyId: json["property_id"],
        savedPropertyDate: DateTime.parse(json["savedPropertyDate"]),
      );

  Map<String, dynamic> toJson() => {
        "favourite_id": favouriteId,
        "userId": userId,
        "property_id": propertyId,
        "savedPropertyDate": savedPropertyDate.toIso8601String(),
      };
}
