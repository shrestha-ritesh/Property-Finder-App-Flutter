import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:propertyfinder/models/property_attributes_model.dart';
import 'package:propertyfinder/modules/listview_page/property_lists.dart';
import '../filter_section.dart';

class ListviewPage extends StatelessWidget {
  List<Property> properties = getPropertyDetails();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.blueGrey[600],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 24, bottom: 12, left: 5, right: 5),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search Property',
                          hintStyle: TextStyle(
                              color: Colors.blueGrey[600].withOpacity(0.5),
                              fontSize: 15),
                          contentPadding:
                              EdgeInsets.only(top: 0.25, left: 4, right: 4),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(2),
                          //   borderSide: BorderSide(color: Colors.black),
                          // ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.filter,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey[600],
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8, left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 32,
                        child: Stack(
                          children: <Widget>[
                            ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                filterOptions("Option 1"),
                                filterOptions("Option 2"),
                                filterOptions("Option 3"),
                                filterOptions("Option 4"),
                                filterOptions("Option 5"),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 28,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    stops: [0.0, 10.0],
                                    colors: [
                                      Colors.blueGrey[600],
                                      Colors.blueGrey[600].withOpacity(0.0),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 24),
                      child: Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(right: 24, left: 24, top: 18, bottom: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    '24',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Results Found',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: buildProperties(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterOptions(String optionName) {
    return GestureDetector(
      onTap: () {
        print(optionName);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.only(right: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            optionName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey[600],
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  //Creating filter for the data:
  List<Widget> buildProperties(BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < properties.length; i++) {
      list.add(
        Hero(
          tag: properties[i].frontImage,
          child: propertyBuild(properties[i], i, context),
        ),
      );
    }
    return list;
  }

  //Creating method propertyBuild for rest of the operations:
  Widget propertyBuild(Property property, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PropertyListsView()));
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 24),
        clipBehavior: Clip.antiAlias, // Needed to be searched
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 210,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(property.frontImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "For " + property.label,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              property.propertyType,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(20.0),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black26,
              //         offset: Offset(0.0, 2.0),
              //         blurRadius: 6.0,
              //       )
              //     ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.attach_money,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          property.price,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.black,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          property.location,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(property.label),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            FilterPage(),
          ],
        );
      },
    );
  }
}
