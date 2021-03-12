class ArticleList {
  String imageUrl;
  String articlHeading;
  String propertyDescription;
  String propertyType;
  String postedDate;

  ArticleList(
      {this.imageUrl,
      this.articlHeading,
      this.propertyDescription,
      this.propertyType,
      this.postedDate});
}

List<ArticleList> articleList = [
  ArticleList(
      imageUrl: 'images/newsArticle1.jpg',
      articlHeading: 'Kathmandu',
      propertyDescription: 'This is the description of the property.',
      propertyType: 'House',
      postedDate: 'SALE'),
  ArticleList(
      imageUrl: 'images/newsArticle1.jpg',
      articlHeading: 'Kathmandu',
      propertyDescription: 'This is the description of the property.',
      propertyType: 'House',
      postedDate: 'SALE'),
  ArticleList(
      imageUrl: 'images/newsArticle1.jpg',
      articlHeading: 'Kathmandu',
      propertyDescription: 'This is the description of the property.',
      propertyType: 'House',
      postedDate: 'SALE'),
  ArticleList(
      imageUrl: 'images/newsArticle1.jpg',
      articlHeading: 'Kathmandu',
      propertyDescription: 'This is the description of the property.',
      propertyType: 'House',
      postedDate: 'SALE'),
];
