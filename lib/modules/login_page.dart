import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/models/login_module.dart';
import 'package:propertyfinder/modules/home/home_page.dart';
import 'package:propertyfinder/modules/signup_page.dart';
import 'package:propertyfinder/progressHUD.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  //variable for hiding the password
  bool hidePassword = true;
  LoginRequestModel loginRequestModel;

  var session = FlutterSession();
  bool isApiCalled = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _loginUI(context),
      inAsyncCall: isApiCalled,
      opacity: 0.3,
    );
  }

  @override
  Widget _loginUI(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Greetings !",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Sign in to the appplication!",
                      style:
                          TextStyle(fontSize: 18, color: Colors.grey.shade400),
                    ),
                  ],
                ),
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Image(
                            image: AssetImage('images/Logoimage.png'),
                            height: 110,
                            fit: BoxFit.fill),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: globalFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (input) => !input.contains("@")
                            ? "please enter valid email"
                            : null,
                        onSaved: (input) => loginRequestModel.email = input,
                        decoration: InputDecoration(
                          labelText: "Email ID",
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade900,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => loginRequestModel.password = input,
                        validator: (input) => input.length < 3
                            ? "Password must contain more than 4 letters"
                            : null,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          labelText: "password",
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade900,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
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
                      SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Homepage();
                              },
                            ));
                          },
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
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
                            // print('This is login page');
                            if (validateAndSave()) {
                              //triggering spinner when login button is pressed.
                              setState(() {
                                isApiCalled = true;
                              });
                              //Importing API service:
                              ApiService apiService = new ApiService();
                              apiService.login(loginRequestModel).then((value) {
                                setState(() {
                                  isApiCalled = false;
                                });
                                if (value.token.isNotEmpty) {
                                  final snackbar = SnackBar(
                                    content: Text("Logged in successful"),
                                  );
                                  scaffoldKey.currentState
                                      .showSnackBar(snackbar);
                                  print('This is value' + value.id.toString());
                                  session.set('name', value.name);
                                  session.set('token', value.token);
                                  session.set('id', value.id);
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage()));
                                  });
                                } else {
                                  final snackbar = SnackBar(
                                    content: Text(value.error),
                                  );
                                  scaffoldKey.currentState
                                      .showSnackBar(snackbar);
                                }
                              });

                              //printing request json
                              print(loginRequestModel.toJson());
                            }
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.black87,
                                  Colors.grey.shade800,
                                  Colors.grey.shade300,
                                ],
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(
                                  maxWidth: double.infinity, minHeight: 40),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have account ?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
                            },
                          ));
                        },
                        child: Text(
                          "Sign up",
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

//This method checks the form is valid or not
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
