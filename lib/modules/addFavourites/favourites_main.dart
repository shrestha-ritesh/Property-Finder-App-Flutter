import 'package:flutter/material.dart';

class AddFavourites extends StatefulWidget {
  @override
  _AddFavouritesState createState() => _AddFavouritesState();
}

class _AddFavouritesState extends State<AddFavourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoutites'),
      ),
    );
  }
}
