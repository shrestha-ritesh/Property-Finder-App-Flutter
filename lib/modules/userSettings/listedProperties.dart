import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:propertyfinder/api/api_get.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/models/Property.dart';
import 'package:propertyfinder/models/add_property_model.dart';
import 'package:propertyfinder/modules/addProperty/basicForm_page.dart';
import 'package:propertyfinder/modules/listview_page/property_lists.dart';
import 'package:propertyfinder/modules/userSettings/editListedProperty.dart';

import '../filter_section.dart';

class UserListedProperty extends StatefulWidget {
  // List<Datum> property;

  // UserListedProperty({@required this.property});
  @override
  _UserListedPropertyState createState() => _UserListedPropertyState();
}

class _UserListedPropertyState extends State<UserListedProperty> {
  // List<Property> properties = getPropertyDetails();
  var session = FlutterSession();
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Datum> properties = [];
  bool _loading;

  @override
  void initState() {
    super.initState();
    Services.getuserListedProperty().then((property) {
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
    Size size = MediaQuery.of(context).size;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                  FlatButton(
                    color: Colors.grey[400],
                    onPressed: () {
                      print("Sort button pressed");
                    },
                    child: Row(
                      children: [
                        Text("Sort"),
                        Icon(Icons.sort),
                      ],
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
                  key: _listKey,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: (properties.length <= 0)
                      ? <Widget>[
                          Container(
                            width: size.width,
                            child: _notPropertyLists(),
                          ),
                        ]
                      : buildProperties(context),
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
                      padding: EdgeInsets.symmetric(vertical: 1),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  "For " + property.propertyStatus,
                                  style: TextStyle(
                                    fontSize: 20,
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
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                buildIconButton(
                                  Icons.edit_sharp,
                                  () {
                                    print("Button has been pressed");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditPropertyPage(
                                                  property: property,
                                                )));
                                  },
                                  Colors.green[100],
                                ),
                                buildIconButton(
                                  Icons.delete_rounded,
                                  () {
                                    session.set("prop_id", property.propertyId);
                                    showAlertDialog(context, index);
                                    // setState(() {
                                    //   properties.removeAt(index);
                                    // });
                                  },
                                  Colors.red,
                                )
                              ],
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

  //Alert dialog
  showAlertDialog(BuildContext dialogContext, int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed: () {
        Navigator.of(dialogContext).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        ApiService apiService = new ApiService();
        apiService.removeListedProperty().then((value) async {
          if (value.success == 1) {
            EasyLoading.showSuccess('Successfully Deleted Property!');
            setState(() {
              properties.removeAt(index);
            });
          }
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Sure ! do you want to delete the listed property ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildIconButton(IconData iconData, VoidCallback press, Color colors) {
    return IconButton(
        icon: Icon(
          iconData,
          color: colors,
          size: 24,
        ),
        onPressed: press);
  }

  Widget _notPropertyLists() {
    return Column(
      children: [
        Text(
          "You have not added property !\n List today!",
        ),
        SizedBox(
          height: 5,
        ),
        FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BasicPageForm()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
              ),
              SizedBox(
                width: 3,
              ),
              Text("Add Property"),
            ],
          ),
        ),
      ],
    );
  }
}
