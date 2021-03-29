import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15 * 2.0),
      //It covers 15% of the screen
      height: size.height * 0.18,
      // color: Colors.black,
      //Stack is the widget which wil allows to overlap the contaier or widget together
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 60,
            ),
            height: size.height * 0.18 - 27,
            decoration: BoxDecoration(
              color: Colors.blueGrey[600],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Hello! ',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                FutureBuilder(
                    future: FlutterSession().get('name'),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.hasData ? snapshot.data : 'Loading',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    }),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.account_circle,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print('Account page');
                  },
                ),
              ],
            ),
          ),
          //Position is the simple widget that helps to positioned the contents of stack
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: 54,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.blueGrey.withOpacity(0.23),
                    ),
                  ]),
              child: TextField(
                onChanged: (value) {
                  print(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search Property',
                  hintStyle: TextStyle(
                      color: Colors.blueGrey[600].withOpacity(0.5),
                      fontSize: 15),
                  contentPadding: EdgeInsets.all(20),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
