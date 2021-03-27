import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:propertyfinder/config/config.dart';
import '../../appBar.dart';

class BasicPageForm extends StatefulWidget {
  @override
  _BasicPageFormState createState() => _BasicPageFormState();
}

class _BasicPageFormState extends State<BasicPageForm> {
//Easy loading
  Timer _timer;

//Another methods
  String _error = 'No Error Dectected';
  Future<bool> checkAndRequestCameraPermissions() async {
    PermissionStatus permission =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.camera]);
      return permissions[PermissionGroup.camera] == PermissionStatus.granted;
    } else {
      return true;
    }
  }

  List<Asset> images = [];
  Dio dio = Dio();

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 7,
      mainAxisSpacing: 5,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 120,
          height: 120,
        );
      }),
    );
  }

  //For grid
  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#657780",
          actionBarTitle: "Photos",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#657780",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      print(images);
    });
  }

  int _currentStep = 0;

  // StepperType _stepperType = StepperType.horizontal;
  // switchStepType() {
  //   setState(() {
  //     _stepperType == StepperType.vertical
  //         ? _stepperType = StepperType.horizontal
  //         : _stepperType = StepperType.vertical;
  //   });
  // }

  //
  int selectRadio;
  String chosenValue;
  List dropdownContents = ["Item 1", "Item 2", "Item 3", "Item 5"];
  @override
  void intitState() {
    super.initState();
    selectRadio = 0;

    //For easy loading (can be removed mark *)
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    //EasyLoading.showSuccess('Use in initState');
  }

  setSelectedRadio(int val) {
    setState(() {
      selectRadio = val;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, "Add Property"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stepper(
                    steps: _stepper(),
                    physics: ClampingScrollPhysics(),
                    currentStep: this._currentStep,
                    onStepTapped: (step) {
                      setState(() {
                        this._currentStep = step;
                      });
                    },
                    onStepContinue: () {
                      //It transfers to another
                      setState(() {
                        if (this._currentStep < this._stepper().length - 1) {
                          this._currentStep = this._currentStep + 1;
                        } else {
                          //Main Functionality for end of the form
                          print('Complete');
                          _saveImage();
                        }
                      });
                    },
                    onStepCancel: () {
                      setState(() {
                        if (this._currentStep > 0) {
                          this._currentStep = this._currentStep - 1;
                        } else {
                          this._currentStep = 0;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Lists for stepper steps
  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
        title: Text('Basic Details'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property For: ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: selectRadio,
                  activeColor: Colors.black,
                  onChanged: (val) {
                    print('This is object ! $val ');
                    setSelectedRadio(val);
                  },
                ),
                Text('Sale'),
                SizedBox(
                  width: 20,
                ),
                Radio(
                  value: 2,
                  groupValue: selectRadio,
                  activeColor: Colors.black,
                  onChanged: (val) {
                    print('This is object ! $val ');
                    setSelectedRadio(val);
                  },
                ),
                Text('Rent'),
                SizedBox(
                  width: 20,
                ),
                Radio(
                  value: 3,
                  groupValue: selectRadio,
                  activeColor: Colors.black,
                  onChanged: (val) {
                    print('This is object ! $val ');
                    setSelectedRadio(val);
                  },
                ),
                Text('Lease'),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Property Type',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Center(
                    child: DropdownButton(
                      value: chosenValue,
                      onChanged: (drpVal) {
                        setState(() {
                          chosenValue = drpVal;
                        });
                      },
                      dropdownColor: Colors.grey,
                      hint: Text("Select any type"),
                      isExpanded: true,
                      //Adding the item of the list
                      items: dropdownContents.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Property Address: ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    // labelText: "Prp",
                    // labelStyle: TextStyle(
                    //   fontSize: 14,
                    //   color: Colors.grey.shade400,
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(
                        color: Colors.grey.shade900,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(
                        color: Colors.blueGrey[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //Next contents
            SizedBox(
              height: 20,
            ),
            Text(
              'Property City',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Center(
                    child: DropdownButton(
                      value: chosenValue,
                      onChanged: (drpVal) {
                        setState(() {
                          chosenValue = drpVal;
                        });
                      },
                      dropdownColor: Colors.grey,
                      hint: Text("Select any City"),
                      isExpanded: true,
                      //Adding the item of the list
                      items: dropdownContents.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            //---------------------------------------------------For property areas of location
            SizedBox(
              height: 18,
            ),
            Text(
              'Property Located Area',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Center(
                    child: DropdownButton(
                      value: chosenValue,
                      onChanged: (drpVal) {
                        setState(() {
                          chosenValue = drpVal;
                        });
                      },
                      dropdownColor: Colors.grey,
                      hint: Text("Select any areas"),
                      isExpanded: true,
                      //Adding the item of the list
                      items: dropdownContents.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        isActive: _currentStep >= 0,
        state: StepState.editing,
      ),
      Step(
        title: Text('Property Details'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Property built-up Area: ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "e.g. 12"),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 100,
                  child: DropdownButton(
                    value: chosenValue,
                    onChanged: (drpVal) {
                      setState(() {
                        chosenValue = drpVal;
                      });
                    },
                    dropdownColor: Colors.grey,
                    iconEnabledColor: Colors.black,
                    hint: Text("Anna"),
                    isExpanded: true,
                    //Adding the item of the list
                    items: dropdownContents.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Total Area: ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "e.g. 12"),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 100,
                  child: DropdownButton(
                    value: chosenValue,
                    onChanged: (drpVal) {
                      setState(() {
                        chosenValue = drpVal;
                      });
                    },
                    dropdownColor: Colors.grey,
                    iconEnabledColor: Colors.black,
                    hint: Text("Anna"),
                    isExpanded: true,
                    //Adding the item of the list
                    items: dropdownContents.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Road Distance: ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              children: [
                DropdownButton(
                  value: chosenValue,
                  onChanged: (drpVal) {
                    setState(() {
                      chosenValue = drpVal;
                    });
                  },
                  dropdownColor: Colors.grey,
                  iconEnabledColor: Colors.black,
                  hint: Text("PRoperty Face"),
                  isExpanded: true,
                  //Adding the item of the list
                  items: dropdownContents.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Total Area: ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "eg. 10 ft"),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      width: 120,
                      child: DropdownButton(
                        value: chosenValue,
                        onChanged: (drpVal) {
                          setState(() {
                            chosenValue = drpVal;
                          });
                        },
                        dropdownColor: Colors.grey,
                        iconEnabledColor: Colors.black,
                        hint: Text("ft"),
                        isExpanded: true,
                        //Adding the item of the list
                        items: dropdownContents.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      width: 150,
                      child: DropdownButton(
                        value: chosenValue,
                        onChanged: (drpVal) {
                          setState(() {
                            chosenValue = drpVal;
                          });
                        },
                        dropdownColor: Colors.grey,
                        iconEnabledColor: Colors.black,
                        hint: Text("Gravelled"),
                        isExpanded: true,
                        //Adding the item of the list
                        items: dropdownContents.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Building Details:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "2072"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Total Floors"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Total Rooms',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Rooms"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Bathroom"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Kitchen"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Garage"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Living Room"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        isActive: _currentStep >= 1,
        state: StepState.editing,
      ),
      Step(
        title: Text('Property Amenitites'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "New property"),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Text property"),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Mobile No"),
            ),
          ],
        ),
        isActive: _currentStep >= 2,
        state: StepState.editing,
      ),
      //Codes for adding images using milti image picker
      Step(
        title: Text('Property Images'),
        content: Container(
          child: Column(
            children: <Widget>[
              Text("Choose any photos for Property: "),
              FlatButton.icon(
                onPressed: loadAssets,
                icon: Icon(Icons.image),
                label: Text('Select Image'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.black12,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  height: 250,
                  child: buildGridView(),
                ),
              ),
              // RaisedButton(
              //   onPressed: _saveImage,
              //   child: Text('Save'),
              // ),
            ],
          ),
        ),
        isActive: _currentStep >= 3,
        state: StepState.editing,
      ),
      Step(
        title: Text('Property Pricing'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Property Title"),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Property Description"),
              maxLines: 5,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Property Price"),
            ),
          ],
        ),
        isActive: _currentStep >= 4,
        state: StepState.editing,
      ),
    ];
    return _steps;
    // Expanded(
    //   child: buildGridView(),
    // ),
  }

  //SAVE IMAGE FOR THE BACKEND
  _saveImage() async {
    if (images != null) {
      int count = 0;
      for (var i = 0; i < images.length; i++) {
        ByteData byteData = await images[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();

        MultipartFile multipartFile = MultipartFile.fromBytes(
          imageData,
          filename: images[i].name,
          contentType: MediaType('image', 'jpg'),
        );

        FormData formData = FormData.fromMap({"image": multipartFile});
        EasyLoading.show(status: 'uploading...');

        //Image post
        var response = await dio.post(UPLOAD_URL, data: formData);
        if (response.statusCode == 200) {
          EasyLoading.showSuccess('Successfully Stored!');
          print(response.data);
        }
      }
    } else {}
  }
}
