import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:propertyfinder/api/api_get.dart';
import 'package:propertyfinder/models/Property.dart';
import 'package:propertyfinder/modules/listview_page/property_lists.dart';

class SavedProperties extends StatefulWidget {
  @override
  _SavedPropertiesState createState() => _SavedPropertiesState();
}

class _SavedPropertiesState extends State<SavedProperties> {
  bool savedValue = false;
  //For the global Key
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //making the list of datatype of favourites:
  List<Datum> favourites = [];
  int simpleLength;

  @override
  void initState() {
    super.initState();
    Services.getFavouriteProperty().then((favProperty) {
      setState(() {
        favourites = favProperty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> containers = [
      _bodyContents(context),
      _secondContainer(context),
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Saved Property",
              ),
              Tab(
                text: "Saved Search",
              ),
            ],
          ),
          title: Text("Saved"),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }

  Widget _bodyContents(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: buildFavouriteProperties(size, context),
    );
  }

  List<Widget> buildFavouriteProperties(Size size, BuildContext context) {
    List<Widget> list = [];
    simpleLength = favourites.length;
    for (var i = 0; i < favourites.length; i++) {
      list.add(
        Padding(
          padding: EdgeInsets.all(12),
          child: buildingContents(size, context, favourites[i], i),
        ),
      );
    }
    return list;
  }

  Widget buildingContents(
      Size size, BuildContext context, Datum favourites, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PropertyListsView(property: favourites)));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image(
                        fit: BoxFit.fill,
                        alignment: Alignment.topLeft,
                        image: NetworkImage(favourites.images[0]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, top: 15, bottom: 8, right: 8),
                    child: Container(
                      width: size.width * 0.549,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favourites.propertyName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            favourites.propertyAddress,
                            style: TextStyle(fontSize: 15),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Price: " + favourites.propertyPrice.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  !savedValue
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    savedValue = !savedValue;
                                    print('Pressed favorite button');
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _secondContainer(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("This is second page"),
          ],
        ),
      ),
    );
  }
}
