import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  var selectedRange = RangeValues(100, 1000);
  String dropdownValue = 'House';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 24,
        left: 24,
        top: 32,
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Filter",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Search",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            children: <Widget>[
              Text(
                "Price",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "range",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
          RangeSlider(
            values: selectedRange,
            onChanged: (RangeValues newRange) {
              setState(() {
                selectedRange = newRange;
              });
            },
            min: 70,
            max: 1000,
            activeColor: Colors.blueGrey[600],
            inactiveColor: Colors.grey[600],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                r"$80k",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                r"$1000k",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Rooms",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildOption("Any", false),
              buildOption("1", false),
              buildOption("2", false),
              buildOption("3", true),
              buildOption("4+", false),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Bathrooms",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildOption("Any", false),
              buildOption("1", true),
              buildOption("2", false),
              buildOption("3", false),
              buildOption("4", false),
              buildOption("5+", false),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Categories",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          dropDownOption(),
        ],
      ),
    );
  }

  Widget buildOption(String text, bool selected) {
    return Container(
      height: 40,
      width: 55,
      decoration: BoxDecoration(
        color: selected ? Colors.blue[900] : Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
        border: Border.all(
          width: selected ? 0 : 1,
          color: Colors.blueGrey[600],
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget dropDownOption() {
    return Container(
      width: 500,
      child: DropdownButton<String>(
        value: dropdownValue,
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.blueGrey[600]),
        underline: Container(
          height: 2,
          color: Colors.blueGrey[600],
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['House', 'Buildings', 'Apartment', 'Land']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        icon: Icon(Icons.arrow_drop_down),
      ),
    );
  }
}
