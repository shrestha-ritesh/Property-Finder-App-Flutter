import 'dart:async';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertyfinder/api/api_get.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/extra/imageDialog.dart';
import 'package:propertyfinder/models/Favourites.dart';
import 'package:propertyfinder/models/Property.dart';
import 'package:propertyfinder/models/sendFavourites.dart';
import 'package:propertyfinder/modules/listview_page/report_page.dart';
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
  List changedFavourites = [];
  int userId;
  bool checkFav;
  List<FavouritesId> favourites = [];
  //For image name lists
  List<String> imageNameList;
  bool uncheckFavorites = false;
  PageController pageController;

  //Setting the session for the server
  var session = FlutterSession();

  //Declaring global Key for form submission
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //getting the user data:
  FavouriteSave favouriteSave = FavouriteSave();

  buildit() async {
    int user_Id = await session.get("id");
    setState(() {
      userId = user_Id;
    });
  }

  buildFavourites() {
    int prop_id = widget.property.propertyId;
    int user_Id = userId;
    print(user_Id);
    for (var i = 0; i < favourites.length; i++) {
      // print("Tero bajeyfav " + favourites[i].propertyId.toString());
      // print("Tero bajeyfav " + favourites[i].userId.toString());
      // print("Tero asdfadf " + prop_id.toString());
      // print("Tero lsfda " + user_Id.toString());
      changedFavourites.add(favourites[i]);
      if (prop_id == favourites[i].propertyId &&
          user_Id == favourites[i].userId) {
        print("trueasdf");
        return true;
      }
    }
    return false;
  }

  Set<Marker> _markers = {};
  // GoogleMapController controller;
  GoogleMapController controller;

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('mark-i'),
          position: LatLng(
            double.parse(widget.property.latitude),
            double.parse(widget.property.longitude),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validData();
    buildFavourites();
    Services.getProperty().then((propertyData) {
      setState(() {
        property = propertyData;
      });
    });
    //getting the favourites data:
    Services.getFavouritesId().then((favourite) {
      setState(() {
        favourites = favourite;
      });
    });
    buildit();
    checkFav = buildFavourites();
    print("This is check fav ==>" + checkFav.toString());

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
                                icon: Icon(!checkFav
                                    ? Icons.favorite_border
                                    : Icons.favorite),
                                onPressed: () async {
                                  setState(() {
                                    print(checkFav);
                                    checkFav = !checkFav;
                                    buildFavourites();
                                    print('Pressed favorite button');
                                  });
                                  // for loop for checking the data
                                  if (checkFav) {
                                    validData();
                                    print(buildFavourites().toString());
                                    await session.set("removeFavPropId",
                                        widget.property.propertyId);
                                    print(favouriteSave.toJson());
                                    ApiService apiService = new ApiService();
                                    apiService
                                        .savedFavourites(favouriteSave)
                                        .then((value) => {
                                              if (value.success == 1)
                                                {
                                                  EasyLoading.showSuccess(
                                                      'Successfully Saved!')
                                                }
                                            });
                                  }
                                  // //Logic for hitting the backend api of the application
                                  // if (uncheckFavorites) {
                                  //   validData();
                                  //   print("asdfasdf" +
                                  //       favourites[0].propertyId.toString());
                                  //   await session.set("removeFavPropId",
                                  //       widget.property.propertyId);
                                  //   print(favouriteSave.toJson());
                                  //   ApiService apiService = new ApiService();
                                  //   apiService
                                  //       .savedFavourites(favouriteSave)
                                  //       .then((value) => {
                                  //             if (value.success == 1)
                                  //               {
                                  //                 EasyLoading.showSuccess(
                                  //                     'Successfully Saved!')
                                  //               }
                                  //           });
                                  // }
                                  if (!checkFav) {
                                    await session.set("removeFavPropId",
                                        widget.property.propertyId);
                                    print(favouriteSave.toJson());
                                    ApiService apiService = new ApiService();
                                    apiService
                                        .removeFavourite(favouriteSave)
                                        .then((value) => {
                                              if (value.success == 1)
                                                {
                                                  EasyLoading.showSuccess(
                                                      'Removed from Saved!')
                                                }
                                            });
                                  }
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
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[600],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  widget.property.status,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
                        Container(
                          child: (widget.property.propertyType == "House" ||
                                  widget.property.propertyType == "Lamd")
                              ? Text(
                                  "Rs.\t" +
                                      widget.property.propertyPrice.toString() +
                                      "/ Anna",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21,
                                      color: Colors.blueGrey[600]),
                                )
                              : Text(
                                  "Rs.\t" +
                                      widget.property.propertyPrice.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21,
                                      color: Colors.blueGrey[600]),
                                ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Text(
                        //   "Status: " + widget.property.status.toString(),
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 22,
                        //   ),
                        // ),
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
                          child: (widget.property.propertyType == "Land" ||
                                  widget.property.propertyType == "Business"
                              ? Column(
                                  children: [
                                    Card(
                                      clipBehavior: Clip
                                          .antiAlias, // Needed to be searched
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
                                              children: [],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.blueGrey[600],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
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
                                                                  widget
                                                                      .property
                                                                      .propertyTotalArea),
                                                              SizedBox(
                                                                height: 7,
                                                              ),
                                                              buildDetailColumn(
                                                                  "Built-up Area",
                                                                  widget
                                                                      .property
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
                                                                  widget
                                                                      .property
                                                                      .propertyFace),
                                                              SizedBox(
                                                                height: 7,
                                                              ),
                                                              Container(
                                                                child: (widget.property.propertyType == "Land" ||
                                                                        widget.property.propertyType ==
                                                                            "Business" ||
                                                                        widget.property.propertyType ==
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
                                                                  widget
                                                                      .property
                                                                      .roadDistance),
                                                              SizedBox(
                                                                height: 7,
                                                              ),
                                                              buildDetailColumn(
                                                                  "Road type",
                                                                  widget
                                                                      .property
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
                                    ),
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
                                                    Text("Bed Rooms: " +
                                                        widget
                                                            .property
                                                            .otherDetails
                                                            .bedroom),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Container(
                                                  child: (widget
                                                              .property
                                                              .otherDetails
                                                              .bathroom ==
                                                          null)
                                                      ? Row(
                                                          children: [
                                                            Icon(Icons.bathtub),
                                                            SizedBox(width: 5),
                                                            Text("Bathroom: 4"),
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            Icon(Icons.bathtub),
                                                            SizedBox(width: 5),
                                                            Text("Bathroom: " +
                                                                widget
                                                                    .property
                                                                    .otherDetails
                                                                    .bathroom)
                                                          ],
                                                        ),
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Icon(Icons.directions_car),
                                                    SizedBox(width: 5),
                                                    Text("Parking : " +
                                                        widget
                                                            .property
                                                            .otherDetails
                                                            .parking),
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
                                                    Text("Total Rooms: " +
                                                        widget
                                                            .property
                                                            .otherDetails
                                                            .rooms),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Container(
                                                  child: (widget
                                                              .property
                                                              .otherDetails
                                                              .totalFloors ==
                                                          null)
                                                      ? Row(
                                                          children: [
                                                            Icon(Icons
                                                                .apartment),
                                                            SizedBox(width: 5),
                                                            Text("Floors: --"),
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            Icon(Icons
                                                                .apartment),
                                                            SizedBox(width: 5),
                                                            Text("Floors: " +
                                                                widget
                                                                    .property
                                                                    .otherDetails
                                                                    .totalFloors),
                                                          ],
                                                        ),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location (Map)",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 10,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          width: size.width,
                          height: size.height * 0.30,
                          child: GoogleMap(
                            onMapCreated: _onMapCreated(controller),
                            markers: _markers,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                double.parse(widget.property.latitude),
                                double.parse(widget.property.longitude),
                              ),
                              zoom: 14.0,
                            ),
                          ),
                        ),
                      ],
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Posted Date: ",
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
                                      widget.property.propertyCity,
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
                                      widget.property.propertyPrice.toString(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.property.userDetail.name,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.property.propertyAddedDate.year
                                              .toString() +
                                          "/" +
                                          widget
                                              .property.propertyAddedDate.month
                                              .toString() +
                                          "/" +
                                          widget.property.propertyAddedDate.day
                                              .toString(),
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
                    padding: const EdgeInsets.only(bottom: 80, top: 25),
                    child: FlatButton(
                      onPressed: () async {
                        session.set("property_id", widget.property.propertyId);
                        Navigator.push(
                            context,
                            // MaterialPageRoute(
                            //     builder: (context) => PropertyListsView(property: property)));
                            MaterialPageRoute(
                                builder: (context) => ReportPageForm()));
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            width: 1,
                            color: Colors.red,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                              maxWidth: double.infinity, minHeight: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.flag),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Report this property",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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

  void validData() async {
    int userId = await FlutterSession().get("id");
    favouriteSave = FavouriteSave(
      userId: userId.toString(),
      property_id: widget.property.propertyId.toString(),
    );
  }
}
