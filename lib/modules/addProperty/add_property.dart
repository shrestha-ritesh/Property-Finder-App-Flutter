import 'package:flutter/material.dart';
import 'package:propertyfinder/modules/addProperty/basicForm_page.dart';

class AddPropertyMain extends StatefulWidget {
  @override
  _AddPropertyMainState createState() => _AddPropertyMainState();
}

class _AddPropertyMainState extends State<AddPropertyMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Container(
        margin: const EdgeInsets.only(top: 80),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        'Add Your Property for listing today !',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Center(
                      child: Image(
                          image: AssetImage('images/addProperty.gif'),
                          height: 150,
                          fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text('data'),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Looking for the property? You can find the many property with differnet features and attributes as per your needs. This application provides the details information about the property available in all around Nepal.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    // //Butons===========
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BasicPageForm()));
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.blueGrey.shade700,
                                Colors.blueGrey,
                                Colors.grey.shade300,
                              ],
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                maxWidth: double.infinity, minHeight: 10),
                            child: Text(
                              "Add Property",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.blueGrey[600],
    elevation: 0,
    title: Text('Add property'),
    leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        }),
  );
}
