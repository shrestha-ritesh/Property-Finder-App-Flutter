import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:propertyfinder/modules/home/home_page.dart';
import 'modules/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dynamic name = FlutterSession().get('name');
  runApp(MaterialApp(
    // home: name != '' ? Homepage() : Homepage(),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}
