import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String imageName;

  ImageDialog({@override this.imageName});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        width: size.width,
        height: 200,
        // decoration: BoxDecoration(
        //   image: InteractiveViewer(child: Image.asset(imageName))
        //   // DecorationImage(
        //   //   image: ExactAssetImage(imageName),
        //   //   fit: BoxFit.cover,
        //   // ),
        // ),
        child: InteractiveViewer(
          child: Image.network(imageName),
        ),
      ),
    );
  }
}
