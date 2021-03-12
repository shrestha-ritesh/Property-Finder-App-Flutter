import 'package:flutter/material.dart';
import 'package:propertyfinder/modules/home/ListHomePage/new_article.dart';
import 'package:propertyfinder/modules/home/featured_carousel.dart';
import 'package:propertyfinder/modules/home/home_header.dart';
import 'package:propertyfinder/modules/home/property_carousel.dart';
import 'package:propertyfinder/modules/home/title_with_button.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      // It enables the scrolling view on smaller devices.
      child: Column(
        children: <Widget>[
          HomePageHeader(size: size),
          HeaderButton(
            text: "Categories",
            press: () {},
          ),
          //It will cover 40% of the total width
          SingleChildScrollView(
            padding: EdgeInsets.only(right: 20),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                CategoriesContents(
                  categoryName: "Building",
                  press: () {
                    print('Building pressed');
                  },
                ),
                CategoriesContents(
                  categoryName: "Apartment",
                  press: () {
                    print('Apartment pressed');
                  },
                ),
                CategoriesContents(
                  categoryName: "Land",
                  press: () {
                    print('Land pressed');
                  },
                ),
                CategoriesContents(
                  categoryName: "House",
                  press: () {
                    print('House pressed');
                  },
                ),
                CategoriesContents(
                  categoryName: "Business",
                  press: () {
                    print('Business pressed');
                  },
                ),
              ],
            ),
          ),
          PropertyCarousel(),
          FeaturedCarousel(),
          NewArticleView(),
        ],
      ),
    );
  }
}

class CategoriesContents extends StatelessWidget {
  const CategoriesContents({
    Key key,
    this.categoryName,
    this.press,
  }) : super(key: key);

  final String categoryName;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        top: 20 / 2,
        bottom: 20 * 0.25,
      ),
      width: size.width * 0.21,
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.55), BlendMode.dstATop),
                  child: Image.asset("images/Logoimage.png"),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  color: Colors.grey[900],
                ),
              ),
              GestureDetector(
                onTap: press,
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  child: Text(
                    categoryName,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ColorFiltered(
//                     colorFilter: ColorFilter.mode(
//                         Colors.black.withOpacity(0.55), BlendMode.dstATop),
//                     child: Image.asset("images/Logoimage.png"),
//                   ),
//                   Container(
//                     // padding: EdgeInsets.all(10 / 2),
//                     decoration: BoxDecoration(color: Colors.white, boxShadow: [
//                       BoxShadow(
//                         offset: Offset(0, 50),
//                         blurRadius: 50,
//                         color: Colors.blueGrey[600].withOpacity(0.80),
//                       ),
//                     ]),
//                   ),
