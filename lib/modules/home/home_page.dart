import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:propertyfinder/extra/drawer-clipper.dart';
import 'package:propertyfinder/modules/addProperty/add_property.dart';
import 'package:propertyfinder/modules/home/home_body.dart';

import '../../test_page.dart';

class Homepage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final Color primary = Colors.blueGrey[600];
  final Color active = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey.shade100,
      appBar: homeAppBar(),
      drawer: _buildDrawer(),
      body: HomeBody(),
      bottomNavigationBar:
          //Changes
          CurvedNavigationBar(
        color: Colors.blueGrey[600],
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.5),
        buttonBackgroundColor: Colors.blueGrey[600],
        height: 55,
        animationDuration: Duration(
          milliseconds: 280,
        ),
        animationCurve: Curves.linearToEaseOut,
        index: 1,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 24,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            size: 24,
            color: Colors.white,
          ),
          Icon(
            Icons.bookmark,
            size: 24,
            color: Colors.white,
          ),
          Icon(
            Icons.switch_account,
            size: 24,
            color: Colors.white,
          ),
        ],
        onTap: (index) async {
          debugPrint("Current index is $index");
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Homepage()));
          }
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddPropertyMain()));
          }
          if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TestPage()));
          }
          if (index == 3) {
            await Navigator.push(
                context, MaterialPageRoute(builder: (context) => TestPage()));
          }
        },
      ),
      // BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.home,
      //           size: 25,
      //         ),
      //         title: Text('')),
      //     BottomNavigationBarItem(
      //         icon: IconButton(
      //           icon: Icon(
      //             Icons.star,
      //             size: 25,
      //           ),
      //           onPressed: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => TestPage()));
      //           },
      //         ),
      //         title: Text('')),
      //     BottomNavigationBarItem(
      //         icon: IconButton(
      //           icon: Icon(
      //             Icons.add_box,
      //             size: 25,
      //           ),
      //           onPressed: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => AddPropertyMain()));
      //           },
      //         ),
      //         title: Text('')),
      //   ],
      // ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey[600],
      elevation: 0,
      leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            _key.currentState.openDrawer();
          }),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: active,
    );
  }

  Widget _buildRow(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }

  _buildDrawer() {
    return ClipPath(
      clipper: DrawerOvalClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: active,
                      ),
                      onPressed: () {
                        _key.currentState.openEndDrawer();
                      },
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.pink, Colors.deepPurple])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/ownerImage1.png'),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "User Name",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                    "User",
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.home, "Home"),
                  _buildDivider(),
                  _buildRow(Icons.person_pin, "Your profile"),
                  _buildDivider(),
                  _buildRow(Icons.settings, "Settings"),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, "Help"),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
