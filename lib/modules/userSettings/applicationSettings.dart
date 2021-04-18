import 'package:flutter/material.dart';
import 'package:propertyfinder/extra/maps.dart';
import 'package:propertyfinder/modules/profile/editProfile.dart';
import 'package:propertyfinder/modules/userSettings/listedProperties.dart';
import 'package:propertyfinder/modules/userSettings/userProfile.dart';

class ApplicationSettings extends StatefulWidget {
  @override
  _ApplicationSettingsState createState() => _ApplicationSettingsState();
}

class _ApplicationSettingsState extends State<ApplicationSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, right: 12.0, bottom: 12.0, top: 40),
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
                          "New User",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "newuser@gmail.com",
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
            listButtons("Edit Profile", Icons.people, () {
              print("Edit Profile");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));
            }),
            listButtons("Change Password", Icons.lock, () {
              print("Change password");
            }),
            listButtons("Listed Properties", Icons.home_sharp, () {
              print("Listed properties");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserListedProperty()));
            }),
            listButtons("About", Icons.info_rounded, () {
              print("Abouts");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapsGoogle()));
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
                  onPressed: () {},
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
}
