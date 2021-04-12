import 'dart:async';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/config/config.dart';
import 'package:propertyfinder/models/requestModel.dart';

class RequestInspection extends StatefulWidget {
  @override
  _RequestInspectionState createState() => _RequestInspectionState();
}

class _RequestInspectionState extends State<RequestInspection> {
  var selectedRange = RangeValues(300, 1000);
  String chosenValue;
  bool inspection = false;
  bool ratesAndPrice = false;
  bool propertyDetails = false;
  bool simProperties = false;

  //Implementing Controller:
  TextEditingController inspecDesc = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();

  //Declaring global Key for form submission
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //getting the user Request model:
  UserRequest userRequest = UserRequest();
  String selectedDate;

  Timer _timer;

  //Implementing flutter session:
  var session = FlutterSession();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Inspection'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SafeArea(
        child: _requestContent(context),
      ),
    );
  }

  Widget _requestContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Form(
          key: globalFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Inspection Tips",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                inspecVar,
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // For the Request basic description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: inspection,
                                onChanged: (value) {
                                  setState(() {
                                    inspection = !inspection;
                                  });
                                  print("Inspection" + inspection.toString());
                                },
                              ),
                              Text("Site Inspection"),
                              SizedBox(
                                width: 28,
                              ),
                              Checkbox(
                                value: ratesAndPrice,
                                onChanged: (value) {
                                  setState(() {
                                    ratesAndPrice = !ratesAndPrice;
                                  });
                                  print("Rates and Price" +
                                      ratesAndPrice.toString());
                                },
                              ),
                              Text("Rates & price"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: propertyDetails,
                                onChanged: (value) {
                                  setState(() {
                                    propertyDetails = !propertyDetails;
                                  });
                                  print("Property Details" +
                                      propertyDetails.toString());
                                },
                              ),
                              Text("Property Details"),
                              SizedBox(
                                width: 23,
                              ),
                              Checkbox(
                                value: simProperties,
                                onChanged: (value) {
                                  setState(() {
                                    simProperties = !simProperties;
                                  });
                                  print("Similar Properties: " +
                                      simProperties.toString());
                                },
                              ),
                              Text("Similar Properties"),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      validator: (input) =>
                          input == "" ? "Please fill the field !" : null,
                      decoration: InputDecoration(
                        hintText: "Add furthure queries or inspection date",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        fillColor: Colors.grey.shade200,
                      ),
                      controller: inspecDesc,
                    ),
                  ],
                ),
              ),

              //User Detail:
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                          left: 10.0,
                          bottom: 15,
                          top: 5,
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (input) => input == ""
                                  ? "Please write the name !"
                                  : null,
                              decoration: InputDecoration(
                                  hintText: "User Name", labelText: "Name"),
                              controller: userName,
                            ),
                            TextFormField(
                              validator: (input) => !input.contains("@")
                                  ? "Please write valid email !"
                                  : null,
                              decoration: InputDecoration(
                                  hintText: "email", labelText: "Email"),
                              controller: userEmail,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  hintText: "Contact No", labelText: "Phone"),
                              controller: userPhone,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Date For Inspection",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    DateTimePicker(
                      enableSuggestions: true,
                      initialValue: '',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date',
                      onChanged: (val) => {selectedDate = val},
                      validator: (val) {
                        Text("Please select the date!");
                        return null;
                      },
                      onSaved: (val) => {selectedDate = val},
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //Flat Button Container
                    FlatButton(
                      onPressed: () async {
                        if (validate()) {
                          print(userRequest.toJson());
                          ApiService apiService = new ApiService();
                          apiService.userInspection(userRequest).then((value) {
                            if (value.success == 1) {
                              EasyLoading.showSuccess(
                                  'Successfully Requested!');
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.pop(context);
                              });
                            } else {
                              final snackbar = SnackBar(
                                content: Text("Something went wrong !"),
                              );
                              scaffoldKey.currentState.showSnackBar(snackbar);
                            }
                          });
                        }
                      },
                      color: Colors.blueGrey[600],
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                            maxWidth: double.infinity, minHeight: 45),
                        child: Text(
                          "Submit",
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //For posting the data to the server:
  void sendData() {
    userRequest = UserRequest(
      siteInspection: inspection.toString(),
      ratesAndPrice: ratesAndPrice.toString(),
      propertyDetails: propertyDetails.toString(),
      similarProperty: simProperties.toString(),
      inspectionRequestDesc: inspecDesc.text,
      reqUserName: userName.text,
      reqUserEmail: userEmail.text,
      reqUserContact: userPhone.text,
      selectedInspectionDate: selectedDate,
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
