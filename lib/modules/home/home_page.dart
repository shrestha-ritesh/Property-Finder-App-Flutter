import 'package:flutter/material.dart';
import 'package:propertyfinder/modules/home/home_body.dart';

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
            icon: Icon(
              Icons.star,
              size: 25,
            ),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
              size: 25,
            ),
            title: Text(''),
          ),
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
