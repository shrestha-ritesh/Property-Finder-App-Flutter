import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/models/User.dart';
import 'package:propertyfinder/models/userProfileUpdate.dart';
import 'package:propertyfinder/modules/userSettings/userProfile.dart';

class EditProfile extends StatefulWidget {
  final User userData;

  EditProfile({@required this.userData});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();

  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  UpdateProfile updateProfile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  //getting the user detail:
  getUserData() {
    name.text = widget.userData.name;
    email.text = widget.userData.email;
    contact.text = widget.userData.contactNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.blueGrey[600],
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: _bodyContents(),
      ),
    );
  }

  Widget _bodyContents() {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: globalFormKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    top: 40,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserProfile(),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "Edit Information",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Name *",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  _buildTextField("Name", name),
                  Text(
                    "Email: *",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  _buildTextField("Email", email),
                  Text(
                    "Contact Number: *",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  _buildTextField("Contact No", contact),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                child: FlatButton(
                  padding: EdgeInsets.all(12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.green[100],
                  onPressed: () {
                    print("submit button pressed");
                    if (validate()) {
                      print(updateProfile.toJson());
                      ApiService apiService = new ApiService();
                      apiService.updateProfile(updateProfile).then((data) {
                        if (data.success == 1) {
                          EasyLoading.showSuccess('Successfully Updated!');
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.pop(context);
                          });
                        } else {
                          EasyLoading.showError("Opps! unable to update data!");
                        }
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send_outlined,
                        color: Colors.red,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Submit",
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

  Widget _buildTextField(
      String title, TextEditingController textEditingController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        validator: (input) => input == "" ? "Please fill the field !" : null,
        decoration: InputDecoration(
          labelText: title,
        ),
        controller: textEditingController,
      ),
    );
  }

  void assignData() {
    updateProfile = UpdateProfile(
        name: name.text, email: email.text, contactNo: contact.text);
  }

  bool validate() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      assignData();
      form.save();
      return true;
    }
    return false;
  }
}
