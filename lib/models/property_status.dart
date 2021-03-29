class PropertyStatus {
  String propertyType;
  int index;

  PropertyStatus(
    this.propertyType,
    this.index,
  );
}

List<PropertyStatus> getPropertyStatusLists() {
  return <PropertyStatus>[
    PropertyStatus(
      "Sale",
      1,
    ),
    PropertyStatus(
      "Rent",
      2,
    ),
    PropertyStatus(
      "Lease",
      3,
    ),
  ];
}
