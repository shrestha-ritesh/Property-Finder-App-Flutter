import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:propertyfinder/api/api_get.dart';
import 'package:propertyfinder/extra/maps.dart';
import 'package:propertyfinder/models/User.dart';
import 'package:propertyfinder/modules/login_page.dart';
import 'package:propertyfinder/modules/profile/editProfile.dart';
import 'package:propertyfinder/modules/userSettings/listedProperties.dart';
import 'package:propertyfinder/modules/userSettings/userProfile.dart';

class ApplicationSettings extends StatefulWidget {
  @override
  _ApplicationSettingsState createState() => _ApplicationSettingsState();
}

class _ApplicationSettingsState extends State<ApplicationSettings> {
  List<User> userLists = [];
  var session = FlutterSession();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Services.getUserData().then((user) {
      setState(() {
        userLists = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SingleChildScrollView(
        child: buildUserDetails(context, size),
      ),
    );
  }

  //Creating user list build:
  Widget buildUserDetails(BuildContext context, Size size) {
    for (var i = 0; i < userLists.length; i++) {
      return Container(
        child: _buildBody(userLists[i], i, context),
      );
    }
  }

  Widget _buildBody(User userLists, int index, BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 40),
      child: Column(
        children: [
          Column(
            children: [
              UserProfile(),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        userLists.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        userLists.email,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          print("open user image!!");
                        },
                      ),
                    ),
                  ),
                ],
              ),

              //     SizedBox(
              //   height: 44,
              //   width: 44,
              //   child: FlatButton(
              //     padding: EdgeInsets.zero,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(50),
              //         side: BorderSide(color: Colors.white)),
              //     color: Colors.grey,
              //     child: Icon(
              //       Icons.camera_enhance,
              //       color: Colors.black,
              //     ),
              //     onPressed: () {
              //       print("open user image!!");
              //     },
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          listButtons("Edit Profile", Icons.people, () async {
            print("Edit Profile");
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfile(
                          userData: userLists,
                        )));
            setState(() {});
          }),
          listButtons("Change Password", Icons.lock, () {
            print("Change password");
          }),
          listButtons("Listed Properties", Icons.home_sharp, () {
            print("Listed properties");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserListedProperty()));
          }),
          listButtons("About", Icons.info_rounded, () {
            print("Abouts");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapsGoogle()));
          }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              width: 150,
              child: FlatButton(
                padding: EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.grey[300],
                onPressed: () async {
                  await resetSession();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Log Out",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget listButtons(String text, var icons, VoidCallback press) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.grey[300],
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icons,
              color: Colors.blueGrey[600],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  resetSession() async {
    var resetVar;
    await session.set("id", "");
    await session.set("token", "");
    await session.set("removeFavPropId", "");
    await session.set("property_id", "");
  }
}
