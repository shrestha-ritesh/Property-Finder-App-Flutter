import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          BodyTitle(text: "Categories"),
          Spacer(),
          // FlatButton.icon(
          //   padding: EdgeInsets.only(left: 2, right: 10),
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          //   color: Colors.blueGrey[600],
          //   onPressed: () {},
          //   label: Text(
          //     'See more',
          //     style: TextStyle(color: Colors.white, fontSize: 12),
          //   ),
          //   icon: Icon(
          //     Icons.chevron_right,
          //     color: Colors.white,
          //     size: 18,
          //   ),
          // )
        ],
      ),
    );
  }
}

class BodyTitle extends StatelessWidget {
  const BodyTitle({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20 / 4),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: 20 / 4),
              height: 7,
              color: Colors.blueGrey[600].withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
