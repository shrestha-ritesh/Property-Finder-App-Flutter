import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/models/change_password_model.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  //Initializing certain values:
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hidePassword = true;

  //Creating the instance of model:
  ChangePasswordRequest changePasswordRequest = ChangePasswordRequest();

  //Declaring the textfield controller:
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Change Password"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Form(
              key: globalFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Old Password",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: hidePassword,
                        keyboardType: TextInputType.text,
                        validator: (input) => input.length < 5
                            ? "Password must contain more than 5 letters"
                            : null,
                        controller: oldPassword,
                        decoration: InputDecoration(
                            labelText: "Old password",
                            labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade800),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            suffixIcon: IconButton(
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                color: Colors.blueGrey[600].withOpacity(0.4),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                })),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Password",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: hidePassword,
                        keyboardType: TextInputType.text,
                        validator: (input) => input.length < 5
                            ? "Password must contain more than 5 letters"
                            : null,
                        controller: newPassword,
                        decoration: InputDecoration(
                            labelText: "password",
                            labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade800),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            suffixIcon: IconButton(
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                color: Colors.blueGrey[600].withOpacity(0.4),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                })),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: hidePassword,
                        keyboardType: TextInputType.text,
                        validator: (input) => input != newPassword.text
                            ? "Password does not match"
                            : null,
                        decoration: InputDecoration(
                          labelText: "Confirm password",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade800),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          suffixIcon: IconButton(
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: Colors.blueGrey[600].withOpacity(0.4),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Container(
                          child: FlatButton(
                            padding: EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Colors.blueGrey[300],
                            onPressed: () {
                              print("submit button pressed");
                              if (validate()) {
                                print(changePasswordRequest.toJson());
                                ApiService apiService = new ApiService();
                                apiService
                                    .changePasswordApi(changePasswordRequest)
                                    .then(
                                  (value) {
                                    if (value.success == 1) {
                                      EasyLoading.showSuccess(
                                          "Successfully Changed !");
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      final snackbar = SnackBar(
                                        content: Text(value.error),
                                      );
                                      scaffoldKey.currentState
                                          .showSnackBar(snackbar);
                                    }
                                  },
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "Change Password",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Assigning the value with model:
  sendData() {
    changePasswordRequest = ChangePasswordRequest(
      oldPassword: oldPassword.text,
      newPassword: newPassword.text,
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
