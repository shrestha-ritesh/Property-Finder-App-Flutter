import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:propertyfinder/api/api_get.dart';
import 'package:propertyfinder/models/Property.dart';
import 'package:propertyfinder/models/property_model.dart';
import 'package:propertyfinder/modules/listview_page/listview.dart';

// class FeaturedCarousel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//   }
// }
class FeaturedCarousel extends StatefulWidget {
  @override
  _FeaturedCarouselState createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  List<Datum> _property;
  bool _loading;
  var session = FlutterSession();

  @override
  void initState() {
    super.initState();
    Services.getProperty().then((property) {
      setState(() {
        _property = property;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Featured Building',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('This is see more');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListviewPage()));
                },
                child: Text(
                  'See more',
                  style: TextStyle(
                    color: Colors.blueGrey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 330,
          // color: Colors.grey,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _property.length == null ? 0 : _property.length,
            itemBuilder: (BuildContext context, int index) {
              Datum property = _property[index];
              PropertyLists propertyLists = propertyList[index];
              return GestureDetector(
                onTap: () {
                  print("Tap");
                  session.set("property_id", property.propertyId);
                  session.set("user_id", property.userId);
                  print("Property_ID ==>" + property.propertyId.toString());
                  print("User ==> " + property.userId.toString());
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 300,
                  // color: Colors.blueGrey[600],
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 148,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  property.propertyName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Rs." + property.propertyPrice.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  propertyLists.propertyAddress,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                // Text(
                                //   propertyLists.propertyDescription,
                                //   style: TextStyle(color: Colors.grey),
                                // ),
                                SizedBox(
                                    height: 30,
                                    child: Divider(color: Colors.black)),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.bathtub,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "12",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.house,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    Text(
                                      "12",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.house,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    Text(
                                      "12",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.car_rental,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    Text(
                                      "12",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ]),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(
                                height: 180.0,
                                width: 320.0,
                                image: NetworkImage(property.thumbnailImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 10,
                              bottom: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    property.propertyType,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    property.propertyStatus,
                                    style: TextStyle(color: Colors.white),
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
              );
            },
          ),
        ),
      ],
    );
  }
}
