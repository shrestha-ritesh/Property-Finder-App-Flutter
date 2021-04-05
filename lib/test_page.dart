import 'package:flutter/material.dart';
import 'package:propertyfinder/api/api_get.dart';
import 'package:propertyfinder/appBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:propertyfinder/models/Property.dart';
// import 'package:propertyfinder/modules/addProperty/add_property.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<dynamic> imageNameList = [];
  //For getting data from the server:

  Future<String> getImageData() async {
    final String url = "http://10.0.2.2:3000/v1/uploadImages/getimage/24";
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      //Only accepts json response
      headers: {"Accept": "application/json"},
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        setState(() {
          var convertDataToJson = json.decode(response.body);
          imageNameList = convertDataToJson['image_url'];
        });
      }
    } catch (e) {
      print("error loading data !");
      throw Exception(e);
    }

    print(response.body);
    print("Length" + imageNameList.length.toString());
    return "success";
  }

  //Required Declaration in the application:
  PageController pageController;
  // List<String> images = [
  //   'http://10.0.2.2:3000/multipropertyimage/1617179562869.jpeg',
  //   'http://10.0.2.2:3000/multipropertyimage/1617179563505.jpg',
  //   'http://10.0.2.2:3000/multipropertyimage/1617179564123.jpg',
  //   'http://10.0.2.2:3000/multipropertyimage/1617179564645.jpg',
  //   'http://10.0.2.2:3000/multipropertyimage/1617179565073.jpg'
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getImageData();
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, "CAROUSEL"),
      backgroundColor: Colors.black87,
      body: SafeArea(
        // child: FutureBuilder<List<Datum>>(
        //   future: Services.getProperty(),
        // ),
        child: PageView.builder(
            itemBuilder: (context, position) {
              return imageSlider(position);
            },
            controller: pageController,
            itemCount: imageNameList.length),
      ),
    );
  }

  imageSlider(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 200,
            width: Curves.easeInOut.transform(value) * 350,
            child: widget,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(3),
        child: Image.network(
          imageNameList[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
