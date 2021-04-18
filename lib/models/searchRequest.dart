class SearchRequest {
  String propertyAddress;
  String propertyType;
  String propertyStatus;
  String propertyFace;
  String propertySize;
  String roadType;
  String minPrice;
  String maxPrice;

  SearchRequest({
    this.propertyAddress,
    this.propertyType,
    this.propertyStatus,
    this.propertyFace,
    this.propertySize,
    this.roadType,
    this.minPrice,
    this.maxPrice,
  });

  Map<String, dynamic> toJson() => _$ModelToJson(this);

  //Maping the user data in JSON:
  _$ModelToJson(SearchRequest instance) => <String, dynamic>{
        'property_address': instance.propertyAddress,
        'property_type': instance.propertyType,
        'property_status': instance.propertyStatus,
        'property_face': instance.propertyFace,
        'property_total_area': instance.propertySize,
        'road_type': instance.roadType,
        'property_price_min': instance.minPrice,
        'property_price_max': instance.maxPrice,
      };
}
