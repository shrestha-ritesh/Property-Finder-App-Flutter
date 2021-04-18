import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:propertyfinder/api/api_get.dart';
import 'package:propertyfinder/models/Property.dart';
import 'package:propertyfinder/modules/listview_page/property_lists.dart';

import '../filter_section.dart';

class UserListedProperty extends StatefulWidget {
  // List<Datum> property;

  // UserListedProperty({@required this.property});
  @override
  _UserListedPropertyState createState() => _UserListedPropertyState();
}

class _UserListedPropertyState extends State<UserListedProperty> {
  // List<Property> properties = getPropertyDetails();
  List<Datum> properties = [];
  bool _loading;

  @override
  void initState() {
    super.initState();
    Services.getProperty().then((property) {
      setState(() {
        properties = property;
        _loading = false;
      });
    });
    // setState(() {
    //   properties = widget.property;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listed properties"),
        backgroundColor: Colors.blueGrey[600],
      ),
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(right: 24, left: 24, top: 18, bottom: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    properties.length.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Listed Properties',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    width: 10,
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
          tag: properties[i].images[0],
          child: propertyBuild(properties[i], i, context),
        ),
      );
    }
    return list;
  }

  //Creating method propertyBuild for rest of the operations:
  Widget propertyBuild(Datum property, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            // MaterialPageRoute(
            //     builder: (context) => PropertyListsView(property: property)));
            MaterialPageRoute(
                builder: (context) => PropertyListsView(property: property)));
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
                  image: NetworkImage(property.images[0]),
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
                              "For " + property.propertyStatus,
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
                        // Icon(
                        //   Icons.attach_money,
                        //   color: Colors.black,
                        //   size: 20,
                        // ),
                        Text(
                          ("Rs"),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          property.propertyPrice.toString(),
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
                          property.propertyAddress,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
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
