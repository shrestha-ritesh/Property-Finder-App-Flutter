import 'package:flutter/material.dart';
import 'package:propertyfinder/models/property_attributes_model.dart';

class PropertyListsView extends StatelessWidget {
  final Property property;

  PropertyListsView({@required this.property});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Text("This is Property detail !"),
            // Text(property.description)
            // Hero(
            //   tag: property.frontImage,
            //   child: Container(
            //     height: size.height * 0.5,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage(property.frontImage),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     child: Container(),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
