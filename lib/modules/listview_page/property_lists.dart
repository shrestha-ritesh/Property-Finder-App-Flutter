import 'package:flutter/material.dart';
import 'package:propertyfinder/models/property_attributes_model.dart';

// class PropertyListsView extends StatelessWidget {
//   final Property property;

//   PropertyListsView({@required this.property});
//   @override
//   Widget build(BuildContext context) {

// }

class PropertyListsView extends StatefulWidget {
  final Property property;

  PropertyListsView({this.property});
  @override
  _PropertyListsViewState createState() => _PropertyListsViewState();
}

class _PropertyListsViewState extends State<PropertyListsView> {
  List<Property> property;
  bool uncheckFavorites = false;

  @override
  void initState() {
    super.initState();
    property = getPropertyDetails();
  }

  @override
  Widget build(BuildContext context) {
    Size screenWidth = MediaQuery.of(context).size;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: <Widget>[
                  // Text(widget.property.description),
                  Hero(
                    tag: widget.property.frontImage,
                    child: Container(
                      height: size.height * 0.42,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.property.frontImage),
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
                    height: size.height * 0.38,
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow[700],
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
                                    "FOR " + property[0].label,
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
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                property[0].name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
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
                                    "North",
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
                                    property[0].sqm + "/Anna",
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
                                "|\t" + widget.property.label,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text.rich(
                            TextSpan(
                              text: widget.property.name,
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
                                  text: widget.property.location,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Rs.\t" + widget.property.price + "/ Anna",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                color: Colors.blueGrey[600]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(color: Colors.black),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Property Overview: ",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: (widget.property.propertyType == "Land"
                                ? Column(
                                    children: [
                                      Text("This is Buildings"),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text("This is Building/Apartments/House"),
                                    ],
                                  )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            "Property Description: ",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
