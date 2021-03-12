class Property {
  String label;
  String name;
  String propertyType;
  String price;
  String location;
  String sqm;
  String review;
  String description;
  String frontImage;
  String ownerImages;
  List<String> images;

  Property(
    this.label,
    this.name,
    this.propertyType,
    this.price,
    this.location,
    this.sqm,
    this.review,
    this.description,
    this.frontImage,
    this.ownerImages,
    this.images,
  );
}

List<Property> getPropertyDetails() {
  return <Property>[
    Property(
      "RENT",
      "Long Beach Palace",
      "Apartment",
      "2,823.00",
      "Long Beach California",
      "2,568",
      "4.8",
      "It is pretty good for living.",
      "images/category1.jpg",
      "images/ownerImage1.png",
      [
        "images/category4.jpg",
        "images/category2.jpg",
        "images/category3.jpg",
      ],
    ),
    Property(
      "SALE",
      "Short Beach Villa",
      "Building",
      "2,656,655.00",
      "Nepal Kathmandu",
      "2,568",
      "4.5",
      "The property is situated in hear of the Kathmandu.",
      "images/category2.jpg",
      "images/ownerImage1.png",
      [
        "images/category3.jpg",
        "images/category1.jpg",
        "images/category4.jpg",
      ],
    ),
    Property(
      "SALE",
      "State House",
      "House",
      "2,656,655.00",
      "Queensland",
      "2,568",
      "4.5",
      "The property is situated in hear of the Queensland.",
      "images/category3.jpg",
      "images/ownerImage1.png",
      [
        "images/category2.jpg",
        "images/category4.jpg",
        "images/category1.jpg",
      ],
    ),
    Property(
      "SALE",
      "State House",
      "House",
      "25233123",
      "Samakhushi, Kathmandu",
      "2,568",
      "4.5",
      "The property is situated in hear of the Queensland.",
      "images/category4.jpg",
      "images/ownerImage1.png",
      [
        "images/category2.jpg",
        "images/category1.jpg",
        "images/category3.jpg",
      ],
    ),
  ];
}
