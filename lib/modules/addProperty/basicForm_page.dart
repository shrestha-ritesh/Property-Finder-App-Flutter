import 'package:flutter/material.dart';

import '../../appBar.dart';

class BasicPageForm extends StatefulWidget {
  @override
  _BasicPageFormState createState() => _BasicPageFormState();
}

class _BasicPageFormState extends State<BasicPageForm> {
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();

  //
  int selectRadio;
  String chosenValue;
  List dropdownContents = ["Item 1", "Item 2", "Item 3", "Item 5"];
  @override
  void intitState() {
    super.initState();
    selectRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectRadio = val;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, "Basic Details"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Basic Property Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Property For: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: selectRadio,
                        activeColor: Colors.black,
                        onChanged: (val) {
                          print('This is object ! $val ');
                          setSelectedRadio(val);
                        },
                      ),
                      Text('Sale'),
                      SizedBox(
                        width: 20,
                      ),
                      Radio(
                        value: 2,
                        groupValue: selectRadio,
                        activeColor: Colors.black,
                        onChanged: (val) {
                          print('This is object ! $val ');
                          setSelectedRadio(val);
                        },
                      ),
                      Text('Rent'),
                      SizedBox(
                        width: 20,
                      ),
                      Radio(
                        value: 3,
                        groupValue: selectRadio,
                        activeColor: Colors.black,
                        onChanged: (val) {
                          print('This is object ! $val ');
                          setSelectedRadio(val);
                        },
                      ),
                      Text('Lease'),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Property Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Center(
                          child: DropdownButton(
                            value: chosenValue,
                            onChanged: (drpVal) {
                              setState(() {
                                chosenValue = drpVal;
                              });
                            },
                            dropdownColor: Colors.grey,
                            hint: Text("Select any type"),
                            isExpanded: true,
                            //Adding the item of the list
                            items: dropdownContents.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Property Address: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          // labelText: "Prp",
                          // labelStyle: TextStyle(
                          //   fontSize: 14,
                          //   color: Colors.grey.shade400,
                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide(
                              color: Colors.grey.shade900,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide(
                              color: Colors.blueGrey[600],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Next contents
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Property City',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Center(
                          child: DropdownButton(
                            value: chosenValue,
                            onChanged: (drpVal) {
                              setState(() {
                                chosenValue = drpVal;
                              });
                            },
                            dropdownColor: Colors.grey,
                            hint: Text("Select any City"),
                            isExpanded: true,
                            //Adding the item of the list
                            items: dropdownContents.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //---------------------------------------------------For property areas of location
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Property Located Area',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Center(
                          child: DropdownButton(
                            value: chosenValue,
                            onChanged: (drpVal) {
                              setState(() {
                                chosenValue = drpVal;
                              });
                            },
                            dropdownColor: Colors.grey,
                            hint: Text("Select any areas"),
                            isExpanded: true,
                            //Adding the item of the list
                            items: dropdownContents.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton.icon(
                          icon: Icon(Icons.arrow_right_sharp),
                          label: Text('Next'),
                          color: Colors.blueGrey.shade600,
                          highlightColor: Colors.grey,
                          hoverColor: Colors.white,
                          onPressed: () {
                            print('This is universe');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //   child: Column(
              //     children: [
              //       Text('Property Name'),
              //       TextFormField(
              //         keyboardType: TextInputType.text,
              //         decoration: InputDecoration(
              //           // labelText: "Prp",
              //           // labelStyle: TextStyle(
              //           //   fontSize: 14,
              //           //   color: Colors.grey.shade400,
              //           // ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.grey.shade900,
              //             ),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.red,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 30,
              //       ),
              //       Text('Property description'),
              //       TextFormField(
              //         keyboardType: TextInputType.text,
              //         decoration: InputDecoration(
              //           // labelText: "Prp",
              //           // labelStyle: TextStyle(
              //           //   fontSize: 14,
              //           //   color: Colors.grey.shade400,
              //           // ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.grey.shade900,
              //             ),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.red,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 30,
              //       ),
              //       Text('Property type'),
              //       TextFormField(
              //         keyboardType: TextInputType.text,
              //         decoration: InputDecoration(
              //           // labelText: "Prp",
              //           // labelStyle: TextStyle(
              //           //   fontSize: 14,
              //           //   color: Colors.grey.shade400,
              //           // ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.grey.shade900,
              //             ),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.red,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 30,
              //       ),
              //       Text('Property address'),
              //       TextFormField(
              //         keyboardType: TextInputType.text,
              //         decoration: InputDecoration(
              //           // labelText: "Prp",
              //           // labelStyle: TextStyle(
              //           //   fontSize: 14,
              //           //   color: Colors.grey.shade400,
              //           // ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.grey.shade900,
              //             ),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.red,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 30,
              //       ),
              //       Text('Property Price'),
              //       TextFormField(
              //         keyboardType: TextInputType.number,
              //         decoration: InputDecoration(
              //           // labelText: "Prp",
              //           // labelStyle: TextStyle(
              //           //   fontSize: 14,
              //           //   color: Colors.grey.shade400,
              //           // ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.grey.shade900,
              //             ),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.red,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 30,
              //       ),
              //       Text('Property status'),
              //       TextFormField(
              //         keyboardType: TextInputType.text,
              //         decoration: InputDecoration(
              //           // labelText: "Prp",
              //           // labelStyle: TextStyle(
              //           //   fontSize: 14,
              //           //   color: Colors.grey.shade400,
              //           // ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.grey.shade900,
              //             ),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: BorderSide(
              //               color: Colors.red,
              //             ),
              //           ),
              //         ),
              //       ),
              //       //Butons===========
              //       Container(
              //         height: 50,
              //         width: double.infinity,
              //         child: FlatButton(
              //           onPressed: () {
              //             print('object');
              //           },
              //           child: Ink(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(6),
              //               gradient: LinearGradient(
              //                 begin: Alignment.centerLeft,
              //                 end: Alignment.centerRight,
              //                 colors: [
              //                   Colors.black87,
              //                   Colors.grey.shade800,
              //                   Colors.grey.shade300,
              //                 ],
              //               ),
              //             ),
              //             child: Container(
              //               alignment: Alignment.center,
              //               constraints: BoxConstraints(
              //                   maxWidth: double.infinity, minHeight: 40),
              //               child: Text(
              //                 "Submit",
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ),
              //           ),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
