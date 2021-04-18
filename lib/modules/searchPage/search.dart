import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/extra/filterChip.dart';
import 'package:propertyfinder/models/searchRequest.dart';
import 'package:propertyfinder/modules/listview_page/listview.dart';

class SearchPageForm extends StatefulWidget {
  final String passedPropertyFace;

  SearchPageForm({Key key, @required this.passedPropertyFace})
      : super(key: key);
  @override
  _SearchPageFormState createState() => _SearchPageFormState();
}

class _SearchPageFormState extends State<SearchPageForm>
    with SingleTickerProviderStateMixin {
  //Creating the instance of the Search Request class:
  SearchRequest searchRequest;
  Icon cusIcon = Icon(Icons.search);
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Widget cusSearchBar = Text("Search Property");
  AnimationController _controller;
  String chosenCategories;
  String chosenPropertyFor;
  String chosenPropertyFace;
  String chosenPropertySize;
  Timer _timer;
  String chosenRoadType;
  String chosenMinimumPrice;
  String changedMinValue;
  String chosenMaximumPrice;
  String changedMaxVlaue;
  String changedRoadType, changedPropertyArea;
  List roadTypeList = ["Gravelled", "Paved", "Black Toppe", "Alley"];
  List<String> choices = ['Sales', 'Rent', 'Lease'];
  List minMaxRate = [
    "10000",
    "100000",
    "500000",
    "1000000",
    "2000000",
    "5000000",
    "1000000",
    "2000000",
    "3000000",
    "4000000",
    "5000000",
    "10000000",
    "20000000",
    "50000000",
    "70000000",
    "100000000"
  ];
  List propertyMeasurementType = [
    "Anna",
    "Ropani",
    "Sq Feet",
    "Sq Meter",
    "Daam",
    "Paisa",
    "Bigha",
    "Kattha",
    "Dhur",
    "Haat",
    "Acres"
  ];
  List propertyFaceList = ["East", "West", "North", "South"];

  List categoriesTitle = ["House", "Apartment", "Business", "Land", "All"];

  List listOfICons = [
    Icons.house_outlined,
    Icons.apartment_outlined,
    Icons.business_center,
    Icons.landscape,
    Icons.category_outlined
  ];

  String roadType;
  String chosenTotalArea;

  TextEditingController chosenAddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    choices = ['Sales', 'Rent', 'Lease'];
    setState(() {
      chosenPropertyFace = widget.passedPropertyFace;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: globalFormKey,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[600],
          title: cusSearchBar,
          titleSpacing: 1.8,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (this.cusIcon.icon == Icons.search) {
                    this.cusIcon = Icon(Icons.cancel);
                    this.cusSearchBar = Container(
                      height: 34,
                      child: TextFormField(
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search address",
                            filled: true,
                            fillColor: Colors.white),
                        validator: (input) =>
                            input == "" ? "Please fill the field !" : null,
                        controller: chosenAddress,
                        style: TextStyle(
                            color: Colors.black, fontSize: 16.0, height: 0.1),
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                      ),
                    );
                  } else {
                    this.cusIcon = Icon(Icons.search);
                    this.cusSearchBar = Text("Search Property");
                  }
                });
              },
              icon: cusIcon,
            ),
          ],
          elevation: 20.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 12.0, left: 12.0, right: 12.0, top: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 23,
                        ),
                      ),
                      Container(
                        width: size.width * 1,
                        height: size.height * 0.18,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoriesTitle.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  buildBody(size, listOfICons, categoriesTitle,
                                      index),
                                  SizedBox(
                                    width: 13,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Property Available For:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: size.width,
                        height: size.height * 0.10,
                        child: FilterChipWidget(
                          chipName: 'elements',
                          passedItems: ["Sale", "Rent", "Lease"],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 8.0,
                      //     vertical: 12,
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: <Widget>[
                      //       buildOption("Rent", false),
                      //       SizedBox(
                      //         width: 14,
                      //       ),
                      //       buildOption("Sale", false),
                      //       SizedBox(
                      //         width: 14,
                      //       ),
                      //       buildOption("Lease", false),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Text(
                  "Property Face / Directions:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Container(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: size.width,
                        height: size.height * 0.05,
                        child: FilterChipWidget(
                          chipName: 'elements1',
                          passedItems: ["East", "West", "North", "South"],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Other Details",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 160,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(
                                        0, 0.5), // changes position of shadow
                                  ),
                                ],
                                // border: Border.all(),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Property Size: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Divider(
                                      height: 3,
                                    ),
                                    DropdownButtonFormField(
                                      value: chosenPropertySize,
                                      // validator: (value) => value == null
                                      //     ? 'field required'
                                      //     : null,
                                      onChanged: (drpVal) {
                                        setState(() {
                                          chosenPropertySize = drpVal;
                                          changedPropertyArea = drpVal;
                                        });
                                      },
                                      dropdownColor: Colors.grey,
                                      iconEnabledColor: Colors.black,
                                      hint: Text("Anna"),
                                      isExpanded: true,
                                      //Adding the item of the list
                                      items: propertyMeasurementType
                                          .map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Text(valueItem),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              width: 160,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(
                                        0, 0.5), // changes position of shadow
                                  ),
                                ],
                                // border: Border.all(),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Road Type: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Divider(
                                      height: 3,
                                    ),
                                    DropdownButtonFormField(
                                      value: chosenRoadType,
                                      // validator: (value) => value == null
                                      //     ? 'field required'
                                      //     : null,
                                      onChanged: (drpVal) {
                                        setState(() {
                                          chosenRoadType = drpVal;
                                          changedRoadType = drpVal;
                                        });
                                      },
                                      dropdownColor: Colors.grey,
                                      iconEnabledColor: Colors.black,
                                      hint: Text("Gravelled"),
                                      isExpanded: true,
                                      //Adding the item of the list
                                      items: roadTypeList.map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Text(valueItem),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 0.5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Min Price: ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Divider(
                                    height: 3,
                                  ),
                                  Column(
                                    children: [
                                      DropdownButtonFormField(
                                        value: chosenMinimumPrice,
                                        // validator: (value) => value == null
                                        //     ? 'field required'
                                        //     : null,
                                        onChanged: (drpVal2) {
                                          setState(() {
                                            chosenMinimumPrice = drpVal2;
                                            changedMinValue = drpVal2;
                                          });
                                        },
                                        dropdownColor: Colors.grey,
                                        iconEnabledColor: Colors.black,
                                        hint: Text("500,0000/-"),
                                        isExpanded: true,
                                        //Adding the item of the list
                                        items: minMaxRate.map((valueItem) {
                                          return DropdownMenuItem(
                                            value: valueItem,
                                            child: Text(valueItem),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Container(
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 0.5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Max Price: ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Divider(
                                    height: 3,
                                  ),
                                  DropdownButtonFormField(
                                    value: chosenMaximumPrice,
                                    // validator: (value1) => value1 == null
                                    //     ? 'field required'
                                    //     : null,
                                    onChanged: (drpVal) {
                                      setState(() {
                                        chosenMaximumPrice = drpVal;
                                        changedMaxVlaue = drpVal;
                                      });
                                    },
                                    dropdownColor: Colors.grey,
                                    iconEnabledColor: Colors.black,
                                    hint: Text("1,00,0000/-"),
                                    isExpanded: true,
                                    //Adding the item of the list
                                    items: minMaxRate.map((valueItem1) {
                                      return DropdownMenuItem(
                                        value: valueItem1,
                                        child: Text(valueItem1.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //For Bottom buttons:
                Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 5),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: size.width * 0.35,
                        child: FlatButton(
                          onPressed: () {
                            print("Reset Filter");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                maxWidth: double.infinity, minHeight: 40),
                            child: Text(
                              "Reset Filter",
                              style: TextStyle(
                                color: Colors.blueGrey[600],
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: Colors.blueGrey[600],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        height: 50,
                        width: size.width * 0.35,
                        child: FlatButton(
                          onPressed: () async {
                            if (validate()) {
                              print(searchRequest.toJson());
                              ApiService apiService = new ApiService();
                              apiService
                                  .searchProperty(searchRequest)
                                  .then((value) {
                                if (value.length <= 0) {
                                  final snackbar = SnackBar(
                                    content: Text("Something went wrong !"),
                                  );
                                  scaffoldKey.currentState
                                      .showSnackBar(snackbar);
                                } else {
                                  print(value[0].propertyName);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ListViewPage(property: value)));
                                }
                              });
                            }
                          },
                          color: Colors.grey[850],
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                maxWidth: double.infinity, minHeight: 40),
                            child: Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
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
        ),
      ),
    );
  }

  Widget buildBody(Size size, var passedIcons, var passedTitle, int index) {
    bool selected = false;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () {
          // print(passedTitle[index]);

          setState(() {
            selected = !selected;
            if (chosenCategories == passedTitle[index]) {
              chosenCategories = "";
              selected = false;
            } else {
              chosenCategories = passedTitle[index];
            }
          });
          print(chosenCategories);
          print(selected);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: selected ? Colors.blueGrey[600] : Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 0.5), // changes position of shadow
              ),
            ],
          ),
          width: size.width * 0.24,
          height: size.height * 0.14,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                passedIcons[index],
                size: 50,
                color: Colors.blueGrey[600],
              ),
              Text(
                passedTitle[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOption(String text, bool selected) {
    return Container(
      height: 40,
      width: 55,
      decoration: BoxDecoration(
        color: selected ? Colors.blue[900] : Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
        border: Border.all(
          width: selected ? 0 : 1,
          color: Colors.blueGrey[600],
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  //Setting the data with model for posting the data.
  void sendData() {
    searchRequest = SearchRequest(
      propertyAddress: chosenAddress.text,
      propertyType:
          (chosenCategories == null ? chosenCategories = "" : chosenCategories),
      propertyStatus: "",
      propertyFace: "",
      propertySize: (chosenPropertySize == null
          ? changedPropertyArea = ""
          : chosenPropertySize),
      roadType:
          (chosenRoadType == null ? changedRoadType = "" : chosenRoadType),
      minPrice: (chosenMinimumPrice == null)
          ? changedMinValue = "200"
          : chosenMinimumPrice,
      maxPrice: (chosenMaximumPrice == null)
          ? changedMaxVlaue = "10000000000"
          : chosenMaximumPrice,
    );
  }

  bool validate() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      sendData();
      form.save();
      return true;
    }
    return false;
  }
}
