import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:propertyfinder/modules/easy_loading/newloading.dart';
import 'modules/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dynamic name = FlutterSession().get('name');
  runApp(MaterialApp(
    // home: name != '' ? Homepage() : Homepage(),
    home: MyApp(),
  ));
  configLoading(); //easy loader
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
      builder: EasyLoading.init(), //easy loader
    );
  }
}
