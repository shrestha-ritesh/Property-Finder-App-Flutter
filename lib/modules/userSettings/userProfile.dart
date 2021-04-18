import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          Container(
            height: 90,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient:
                    LinearGradient(colors: [Colors.pink, Colors.deepPurple])),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/ownerImage1.png'),
            ),
          ),
          Positioned(
            right: -10,
            bottom: 0,
            child: SizedBox(
              height: 44,
              width: 44,
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white)),
                color: Colors.grey,
                child: Icon(
                  Icons.camera_enhance,
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
    );
  }
}
