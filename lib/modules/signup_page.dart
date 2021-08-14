import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/models/register_module.dart';
import 'package:propertyfinder/modules/login_page.dart';
import 'package:propertyfinder/progressHUD.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Initializing certain values:
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;
  RegisterRequestModel registerRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool apiCalled = false;

  @override
  void initState() {
    super.initState();
    registerRequestModel = new RegisterRequestModel();
  }

  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _registerUI(context),
      inAsyncCall: apiCalled,
      opacity: 0.3,
    );
  }

  @override
  Widget _registerUI(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Sign up to get started",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: globalFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (input) =>
                            !input.contains("") ? "please enter name!" : null,
                        onSaved: (input) => registerRequestModel.name = input,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => registerRequestModel.email = input,
                        validator: (input) => !input.contains("@")
                            ? "please enter valid email"
                            : null,
                        decoration: InputDecoration(
                          labelText: "email",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: hidePassword,
                        keyboardType: TextInputType.text,
                        onSaved: (input) =>
                            registerRequestModel.password = input,
                        validator: (input) => input.length < 5
                            ? "Password must contain more than 5 letters"
                            : null,
                        decoration: InputDecoration(
                            labelText: "password",
                            labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
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
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: hidePassword,
                        keyboardType: TextInputType.text,
                        onSaved: (input) =>
                            registerRequestModel.passwordConfirm = input,
                        validator: (input) => input.length < 5
                            ? "Password must contain more than 5 letters"
                            : null,
                        decoration: InputDecoration(
                          labelText: "confirm Password",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (input) => input.length < 10
                            ? "phone number must contain 10 letters"
                            : null,
                        onSaved: (input) =>
                            registerRequestModel.contact_no = input,
                        decoration: InputDecoration(
                          labelText: "contact No",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                            onPressed: () {
                              // print('Register');
                              if (validateAndSave()) {
                                //trigering the spinner
                                setState(() {
                                  apiCalled = true;
                                });
                                ApiService apiService = new ApiService();
                                apiService
                                    .register(registerRequestModel)
                                    .then((value) {
                                  setState(() {
                                    apiCalled = false;
                                  });
                                  if (value.error.isEmpty) {
                                    final snackBar = SnackBar(
                                      content: Text("Sucessfully Registered !"),
                                    );
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text(value.error),
                                    );
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                  }
                                });
                                print("Register");
                                print(registerRequestModel.toJson());
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.black87,
                                      Colors.grey.shade800,
                                      Colors.grey.shade300,
                                    ]),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                  minHeight: 50,
                                  maxWidth: double.infinity,
                                ),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already member?",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
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

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    //If form is valid then it returns true
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
