import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:propertyfinder/api/api_get.dart';
import 'package:propertyfinder/extra/imageDialog.dart';
import 'package:propertyfinder/models/Property.dart';
import 'package:propertyfinder/models/property_attributes_model.dart';
import 'package:propertyfinder/modules/home/ListHomePage/new_article.dart';
import 'package:propertyfinder/modules/listview_page/requestInspection.dart';

// class PropertyListsView extends StatelessWidget {
//   final Property property;

//   PropertyListsView({@required this.property});
//   @override
//   Widget build(BuildContext context) {

// }

class PropertyListsView extends StatefulWidget {
  final Datum property;

  PropertyListsView({this.property});
  @override
  _PropertyListsViewState createState() => _PropertyListsViewState();
}

class _PropertyListsViewState extends State<PropertyListsView> {
  List<Datum> property = [];
  //For image name lists
  List<String> imageNameList;
  bool uncheckFavorites = false;
  PageController pageController;

  //Setting the session for the server
  var session = FlutterSession();

  @override
  void initState() {
    super.initState();
    Services.getProperty().then((propertyData) {
      setState(() {
        property = propertyData;
      });
    });
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    imageNameList = widget.property.images;

    Size screenWidth = MediaQuery.of(context).size;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 10,
        ),
        width: screenWidth.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              child: FloatingActionButton.extended(
                heroTag: "btn1",
                onPressed: () {
                  print("Button call has been pressed");
                },
                backgroundColor: Colors.grey[800],
                label: Text('Call'),
                icon: Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 150,
              child: FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: () {
                  print("Button call has been pressed");
                },
                backgroundColor: Colors.grey[800],
                label: Text('Message'),
                icon: Icon(
                  Icons.message,
                  color: Colors.red.shade600,
                ),
                hoverColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                // Text(widget.property.description),
                Hero(
                  tag: widget.property.images[0],
                  child: Container(
                    height: size.height * 0.435,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.property.images[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          stops: [0.4, 1.0],
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //For property Details of the Specific property
                Container(
                  height: size.height * 0.42,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 21, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.yellowAccent[700],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              width: 110,
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "FOR " + widget.property.propertyStatus,
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: IconButton(
                                icon: Icon(!uncheckFavorites
                                    ? Icons.favorite_border
                                    : Icons.favorite),
                                onPressed: () {
                                  setState(() {
                                    uncheckFavorites = !uncheckFavorites;
                                    print('Pressed favorite button');
                                  });
                                },
                              )),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 24),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       // Text(
                      //       //   property[0].name,
                      //       //   style: TextStyle(
                      //       //     color: Colors.white,
                      //       //     fontSize: 18,
                      //       //     fontWeight: FontWeight.w600,
                      //       //   ),
                      //       // ),
                      //       // Container(
                      //       //   height: 50,
                      //       //   width: 50,
                      //       //   decoration: BoxDecoration(
                      //       //     color: Colors.white,
                      //       //     shape: BoxShape.circle,
                      //       //   ),
                      //       //   child: Center(
                      //       //       child: IconButton(
                      //       //     icon: Icon(!uncheckFavorites
                      //       //         ? Icons.favorite_border
                      //       //         : Icons.favorite),
                      //       //     onPressed: () {
                      //       //       setState(() {
                      //       //         uncheckFavorites = !uncheckFavorites;
                      //       //         print('Pressed favorite button');
                      //       //       });
                      //       //     },
                      //       //   )),
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 24, right: 24, top: 0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.directions,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  widget.property.propertyFace,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.aspect_ratio,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  widget.property.propertyTotalArea,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     height: size.height * 0.55,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(30),
                //         topRight: Radius.circular(30),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 16.0, left: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[600],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  widget.property.propertyType,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "|\t" + widget.property.propertyStatus,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text.rich(
                          TextSpan(
                            text: widget.property.propertyName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text.rich(
                              TextSpan(
                                text: widget.property.propertyAddress,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Rs.\t" +
                              widget.property.propertyPrice.toString() +
                              "/ Anna",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              color: Colors.blueGrey[600]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black,
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Property Overview: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: (widget.property.propertyType == "Land"
                              ? Column(
                                  children: [
                                    Text("This is Land"),
                                  ],
                                )
                              : Card(
                                  clipBehavior:
                                      Clip.antiAlias, // Needed to be searched
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text("This is "),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.king_bed,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text("Bed Rooms: 12"),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Icon(Icons.bathtub),
                                                    SizedBox(width: 5),
                                                    Text("Bathroom: 10"),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Icon(Icons.directions_car),
                                                    SizedBox(width: 5),
                                                    Text("Parking : 10"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.roofing,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text("Total Rooms: 12"),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Icon(Icons.apartment),
                                                    SizedBox(width: 5),
                                                    Text("Floors: 10"),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Icon(Icons.kitchen),
                                                    SizedBox(width: 5),
                                                    Text("Kitchen : 10"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          height: 2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blueGrey[600],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Text(
                                                    "Detail Information: ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          buildDetailColumn(
                                                              "Total Area",
                                                              widget.property
                                                                  .propertyTotalArea),
                                                          SizedBox(
                                                            height: 7,
                                                          ),
                                                          buildDetailColumn(
                                                              "Built-up Area",
                                                              widget.property
                                                                  .builtUpArea),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        children: [
                                                          buildDetailColumn(
                                                              "Property Face",
                                                              widget.property
                                                                  .propertyFace),
                                                          SizedBox(
                                                            height: 7,
                                                          ),
                                                          Container(
                                                            child: (widget.property.propertyType == "Land" ||
                                                                    widget.property
                                                                            .propertyType ==
                                                                        "Business" ||
                                                                    widget.property
                                                                            .propertyType ==
                                                                        "Apartment")
                                                                ? buildDetailColumn(
                                                                    "Built Year",
                                                                    "-")
                                                                : buildDetailColumn(
                                                                    "Built Year",
                                                                    widget
                                                                        .property
                                                                        .otherDetails
                                                                        .builtYear),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        children: [
                                                          buildDetailColumn(
                                                              "Road Accessed",
                                                              widget.property
                                                                  .roadDistance),
                                                          SizedBox(
                                                            height: 7,
                                                          ),
                                                          buildDetailColumn(
                                                              "Road type",
                                                              widget.property
                                                                  .roadType),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 24, left: 20, bottom: 24, top: 20),
                    child: Text(
                      "Photos",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 180,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 24,
                      ),
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: getPhotos(widget.property.images),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Property Description: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // Text(
                          //   widget.property.description,
                          //   textAlign: TextAlign.justify,
                          //   style: TextStyle(fontSize: 16),
                          // ),
                          ExpandableText(
                            widget.property.propertyDescription,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                            expandText: 'Read More',
                            collapseText: 'Show less',
                            maxLines: 3,
                            linkColor: Colors.blueGrey[600],
                          ),
                        ],
                      ),
                    ),
                  ),

                  //For Location
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    child: Text(
                      "Location (Map)",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Request for inspection
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    child: Text(
                      "Inspection",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: size.width * 1.2,
                    child: Column(
                      children: [
                        Text(
                          "You can request the owner for the live insppection of the ropperty! ",
                        ),
                        SizedBox(height: 5),
                        FlatButton(
                          onPressed: () async {
                            print("Requested for Inspection");
                            // _showBottomSheet(context);
                            // RequestInspection();
                            session.set(
                                "property_id", widget.property.propertyId);
                            int userId = await FlutterSession().get("id");
                            print(widget.property.propertyId);
                            print("This is user if ==> $userId");
                            Navigator.push(
                                context,
                                // MaterialPageRoute(
                                //     builder: (context) => PropertyListsView(property: property)));
                                MaterialPageRoute(
                                    builder: (context) => RequestInspection()));
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                width: 1,
                                color: Colors.red,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.black87,
                                  Colors.grey.shade800,
                                  Colors.grey.shade300,
                                ],
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(
                                  maxWidth: double.infinity, minHeight: 40),
                              child: Text(
                                "Request For Insection",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //For property details:
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      right: 4,
                      left: 4,
                      bottom: 10,
                    ),
                    child: Text(
                      "Additional Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 18,
                        left: 18,
                        top: 25,
                        bottom: 25,
                      ),
                      child: Container(
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Purpose: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Address: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "City: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "District: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Total Price: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Owner Name: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sale",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.property.propertyAddress,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "City",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "District",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Total Price",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Owner Name",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //For User
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  //   child: Text(
                  //     "User Details",
                  //     style:
                  //         TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                          child: Text(
                            "User Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(
                          height: 2,
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('images/ownerImage1.png'),
                            radius: 28,
                          ),
                          title: Text(widget.property.userDetail.name),
                          subtitle: Text(widget.property.userDetail.contactNo),
                          trailing: Wrap(
                            spacing: 12, // space between two icons
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.call_rounded),
                                onPressed: () {
                                  print("This is call");
                                },
                              ), // icon-1
                              IconButton(
                                icon: Icon(
                                  Icons.message_rounded,
                                  color: Colors.blueGrey,
                                ),
                                onPressed: () {
                                  print("This is message");
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: 10,
                  //     right: 4,
                  //     left: 4,
                  //     bottom: 24,
                  //   ),
                  //   child: Text(
                  //     "Some More Properties",
                  //     style:
                  //         TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: NewArticleView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//For Property details
  Widget buildDetailColumn(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  List<Widget> getPhotos(List<String> images) {
    List<Widget> list = [];
    list.add(SizedBox(width: 5));
    for (var i = 0; i < images.length; i++) {
      list.add(retrivePhoto(images[i], i));
    }
    return list;
  }

  Widget retrivePhoto(String url, int index) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: GestureDetector(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (_) => ImageDialog(
                    imageName: url,
                  ));
        },
        child: Container(
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // void _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //       ),
  //       builder: (context) {
  //         return SingleChildScrollView(
  //           child: RequestInspection(),
  //         );
  //       });
  // }
}
