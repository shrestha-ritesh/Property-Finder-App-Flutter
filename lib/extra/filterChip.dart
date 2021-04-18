import 'package:flutter/material.dart';
import 'package:propertyfinder/modules/searchPage/search.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final List passedItems;
  FilterChipWidget({Key key, this.chipName, this.passedItems})
      : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool isSelected = false;
  int defaultChoiceIndex;
  String selectedValue;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.passedItems.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ChoiceChip(
            label: Text(
              widget.passedItems[index],
            ),
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            selected: defaultChoiceIndex == index,
            backgroundColor: Color(0xffeadffd),
            onSelected: (value) {
              setState(() {
                defaultChoiceIndex = value ? index : null;
                print(widget.passedItems[defaultChoiceIndex]);
                selectedValue = widget.passedItems[defaultChoiceIndex];
                MaterialPageRoute(
                    builder: (context) =>
                        SearchPageForm(passedPropertyFace: selectedValue));
              });
              // if (widget.chipName == "elements") {
              //   SearchPageForm(passedPropertyFace: selectedValue);
              // } else {
              //   SearchPageForm(passedPropertyStatus: selectedValue);
              // }
            },
            selectedColor: Colors.blueGrey[600],
          ),
        );
      },
    );
  }
}
