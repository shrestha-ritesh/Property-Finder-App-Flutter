import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsGoogle extends StatefulWidget {
  @override
  _MapsGoogleState createState() => _MapsGoogleState();
}

Completer<GoogleMapController> _controller = Completer();

class _MapsGoogleState extends State<MapsGoogle> {
  List<Marker> myMarker = [];
  MapType _currentMapType = MapType.normal;
  var setText;

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blueGrey[600],
      child: Icon(
        icon,
        size: 36,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, setText);
          },
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                27.7172,
                85.3240,
              ),
              zoom: 14.0,
            ),
            markers: Set.from(myMarker),
            mapType: _currentMapType,
            onTap: _handleTap,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  button(_onMapTypeButtonPressed, Icons.map),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _handleTap(LatLng tappedPoints) {
    print(tappedPoints);
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(
            markerId: MarkerId(
              tappedPoints.toString(),
            ),
            position: tappedPoints,
            draggable: true,
            onDragEnd: (dragEndPosition) {
              print(dragEndPosition);
            }),
      );
      setText = tappedPoints;
    });
  }
}
