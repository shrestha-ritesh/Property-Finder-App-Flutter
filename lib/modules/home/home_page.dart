import 'package:flutter/material.dart';
import 'package:propertyfinder/modules/addProperty/add_property.dart';
import 'package:propertyfinder/modules/home/home_body.dart';

import '../../test_page.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: homeAppBar(),
      body: HomeBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              title: Text('')),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(
                  Icons.star,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TestPage()));
                },
              ),
              title: Text('')),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(
                  Icons.add_box,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPropertyMain()));
                },
              ),
              title: Text('')),
        ],
      ),
    );
  }
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
          print('This is icon button');
        }),
  );
}
