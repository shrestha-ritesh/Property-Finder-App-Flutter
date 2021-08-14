import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/config/config.dart';
import 'package:propertyfinder/models/report_model.dart';

class ReportPageForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportPageForm> {
  //Calling the constructor from Model:
  ReportRequest reportRequest = ReportRequest();

  //Delcaring Global key form:
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController titleReport = TextEditingController();
  TextEditingController reportDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Using edia query
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Report Property,'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                                    "Report Property",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    reportVar,
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
                  //User Detail:
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Report selected property",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(6),
                          //   color: Colors.grey.shade300,
                          // ),
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
                                      hintText: "Title",
                                      labelText: "Report Heading"),
                                  controller: titleReport,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  maxLines: 5,
                                  controller: reportDescription,
                                  keyboardType: TextInputType.text,
                                  validator: (input) => input == ""
                                      ? "Please fill the field !"
                                      : null,
                                  decoration: InputDecoration(
                                    hintText: "Add Description of the report",
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        //Flat Button Container
                        FlatButton(
                          onPressed: () async {
                            if (validate()) {
                              print(reportRequest.toJson());
                              ApiService apiService = new ApiService();
                              apiService
                                  .addReportProperty(reportRequest)
                                  .then((value) {
                                if (value.success == 1) {
                                  EasyLoading.showSuccess(
                                      "Successfully Reported!");
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  final snackbar = SnackBar(
                                    content: Text("Something went wrong !"),
                                  );
                                  scaffoldKey.currentState
                                      .showSnackBar(snackbar);
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
        ),
      ),
    );
  }

  //For initializing the value with the model:
  void sendData() {
    reportRequest = ReportRequest(
      reportTitle: titleReport.text,
      titleDescription: reportDescription.text,
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
