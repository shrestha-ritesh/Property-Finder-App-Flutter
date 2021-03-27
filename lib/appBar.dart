import 'package:flutter/material.dart';

AppBar homeAppBar(BuildContext context, String titleName) {
  return AppBar(
    backgroundColor: Colors.blueGrey[600],
    elevation: 0,
    title: Text(titleName),
    leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
          // showAlertDialog(context);
        }),
  );
}

//================For Alert dialog buttons
showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Confirm"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Delete Drafts",
      style: TextStyle(
        color: Colors.red,
        fontSize: 20,
      ),
    ),
    content: Text("Would you like to remove all the drafts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
