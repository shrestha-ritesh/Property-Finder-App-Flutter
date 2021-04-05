class PropertyLists {
  String imageUrl;
  String price;
  String propertyAddress;
  String propertyDescription;
  String propertyType;
  String propertyAvailableFor;

  PropertyLists(
      {this.imageUrl,
      this.price,
      this.propertyAddress,
      this.propertyDescription,
      this.propertyType,
      this.propertyAvailableFor});
}

List<PropertyLists> propertyList = [
  PropertyLists(
      imageUrl: 'images/category1.jpg',
      price: 'Rs 10000',
      propertyAddress: 'Kathmandu',
      propertyDescription: 'This is the description of the property.',
      propertyType: 'House',
      propertyAvailableFor: 'SALE'),
  PropertyLists(
      imageUrl: 'images/category2.jpg',
      price: 'Rs 10000',
      propertyAddress: 'Lalitpur',
      propertyDescription: 'This is the description of the property 2.',
      propertyType: 'Apartment',
      propertyAvailableFor: 'RENT'),
  PropertyLists(
      imageUrl: 'images/category1.jpg',
      price: 'Rs 10000',
      propertyAddress: 'Bhaktapur',
      propertyDescription: 'This is the description of the property 3.',
      propertyType: 'Land',
      propertyAvailableFor: 'SALE'),
  PropertyLists(
      imageUrl: 'images/category2.jpg',
      price: 'Rs 10000',
      propertyAddress: 'Perth',
      propertyDescription: 'This is the description of the property 4.',
      propertyType: 'Building',
      propertyAvailableFor: 'RENT'),
  PropertyLists(
      imageUrl: 'images/category2.jpg',
      price: 'Rs 10000',
      propertyAddress: 'Perth',
      propertyDescription: 'This is the description of the property 4.',
      propertyType: 'Building',
      propertyAvailableFor: 'RENT'),
];
