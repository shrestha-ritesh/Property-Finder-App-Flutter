import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fa_stepper/fa_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/config/config.dart';
import 'package:propertyfinder/extra/maps.dart';
import 'package:propertyfinder/models/add_property_model.dart';
// import 'package:propertyfinder/models/property_model.dart';
import '../../appBar.dart';

class BasicPageForm extends StatefulWidget {
  @override
  _BasicPageFormState createState() => _BasicPageFormState();
}

class _BasicPageFormState extends State<BasicPageForm> {
  //For Single image picker:
  File _image;
  final picker = ImagePicker();
  //Implementing controller:
  TextEditingController propertyaddress = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController builtUpArea = TextEditingController();
  TextEditingController totalArea = TextEditingController();
  TextEditingController roadDistance = TextEditingController();
  TextEditingController builtDate = TextEditingController();
  TextEditingController totalFloors = TextEditingController();
  TextEditingController rooms = TextEditingController();
  TextEditingController bathroom = TextEditingController();
  TextEditingController kitchen = TextEditingController();
  TextEditingController garage = TextEditingController();
  TextEditingController livingroom = TextEditingController();
  TextEditingController propertyTitle = TextEditingController();
  TextEditingController propertyDescription = TextEditingController();
  TextEditingController propertyPrice = TextEditingController();
  TextEditingController bedroom = TextEditingController();

  // AddProperty addPropertyModel = AddProperty();

  AddProperty addProperty = AddProperty();
  var session = FlutterSession();

  //Declaring global Key for form submission
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
  List<Asset> imagesv2 = [];

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

  Widget buildGridView1() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 7,
      mainAxisSpacing: 5,
      children: List.generate(imagesv2.length, (index) {
        Asset asset = imagesv2[index];
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

  Future<void> loadAssetsv2() async {
    List<Asset> resultListv2 = [];
    try {
      resultListv2 = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: imagesv2,
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
      imagesv2 = resultListv2;
      print(imagesv2);
    });
  }

  int _currentStep = 0;

  //
  String selectRadio = 'Sale';
  String chosenPropertyType;
  String chosenBuiltArea;
  String chosenTotalArea;
  String propertyFace;
  String roadDistanceType;
  String roadType;
  String chosenValue;
  List propertyType = ["Land", "Business", "Apartment", "House"];
  List propertyMeasurementType = [
    "Anna",
    "Ropani",
    "Sq Feet",
    "Sq Meter",
    "Daam",
    "Paisa",
    "Bigha",
    "Kattha",
    "Dhur",
    "Haat",
    "Acres"
  ];
  List dropdownContents = ["Item 1", "Item 2", "Item 3", "Item 5"];
  List propertyFaceList = ["East", "West", "North", "South"];
  List roadTypeList = ["Gravelled", "Paved", "Black Toppe", "Alley"];
  List measurementList = ["feet", "meter"];

  @override
  void intitState() {
    super.initState();
    selectRadio = '';
    //For easy loading (can be removed mark *)
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    //EasyLoading.showSuccess('Use in initState');
  }

  setSelectedRadio(String val) {
    setState(() {
      selectRadio = val;
    });
  }

  // For Selecting image function:
  Future selectImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: homeAppBar(context, "Add Property"),
      body: Form(
        key: globalFormKey,
        child: FAStepper(
          steps: _stepper(),
          physics: ClampingScrollPhysics(),
          type: FAStepperType.horizontal,
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

                //condition for posting the data in backend
                if (validate()) {
                  ApiService apiService = new ApiService();
                  apiService.addproperty(addProperty).then((value) async {
                    if (value.message.isNotEmpty) {
                      session.set("propertyid", value.propertyid);
                      print('Propertyid');
                      if (value.success == 1) {
                        await _saveImage();
                        //For single content upload
                        // singleUpload();
                        // For Evidence upload:
                        await apiService.saveEvidenceImage(imagesv2);
                        print('Test');
                      } else {
                        print(value.error);
                      }
                      final snackbar = SnackBar(
                        content: Text("Sucessfully Added !!"),
                      );
                      scaffoldKey.currentState.showSnackBar(snackbar);
                      print(value.message);
                    } else {
                      final snackbar = SnackBar(
                        content: Text(value.error),
                      );
                      scaffoldKey.currentState.showSnackBar(snackbar);
                    }
                  });
                } else {
                  // final snackbar = SnackBar(
                  //   content: Text("Please fill all the values  !"),
                  // );
                  // scaffoldKey.currentState.showSnackBar(snackbar);
                  showAlertDialog(context);
                }
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
      ),
    );
  }

// Lists for stepper steps
  List<FAStep> _stepper() {
    List<FAStep> _steps = [
      FAStep(
        title: Text(
          'Basic Details',
          style: TextStyle(fontSize: 17),
        ),
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
                  value: 'Sale',
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
                  value: "Rent",
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
                  value: "Lease",
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
                    child: DropdownButtonFormField(
                      value: chosenPropertyType,
                      onChanged: (drpVal) {
                        setState(() {
                          chosenPropertyType = drpVal;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'field required' : null,
                      dropdownColor: Colors.grey,
                      hint: Text("Select any type"),
                      isExpanded: true,
                      //Adding the item of the list
                      items: propertyType.map((valueItem) {
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
                  controller: propertyaddress,
                  validator: (input) =>
                      input == "" ? "Please fill the field !" : null,
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
                    child: DropdownButtonFormField(
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
                    child: DropdownButtonFormField(
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Location",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(color: Colors.blueGrey[600])),
                        color: Colors.grey[300],
                        child: Text("Pick Location"),
                        onPressed: () async {
                          print("Open Google map");
                          final info = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapsGoogle()));
                          print(info.latitude.toString());
                          setState(() {
                            latitude.text = info.latitude.toString();
                            longitude.text = info.longitude.toString();
                            print("asdfsadf" + latitude.text);
                            print("saasdf" + longitude.text);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Text("Latitude"),
                            TextFormField(
                              decoration: InputDecoration(labelText: "e.g. 12"),
                              controller: latitude,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 160,
                        child: Column(
                          children: [
                            Text("Longitude"),
                            TextFormField(
                              decoration: InputDecoration(labelText: "e.g. 12"),
                              controller: longitude,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 0,
        state: FAStepstate.editing,
      ),
      FAStep(
        title: Text(
          'Property Details',
          style: TextStyle(fontSize: 17),
        ),
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
                    controller: builtUpArea,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 100,
                  child: DropdownButtonFormField(
                    value: chosenBuiltArea,
                    validator: (value) =>
                        value == null ? 'field required' : null,
                    onChanged: (drpVal) {
                      setState(() {
                        chosenBuiltArea = drpVal;
                      });
                    },
                    dropdownColor: Colors.grey,
                    iconEnabledColor: Colors.black,
                    hint: Text("Anna"),
                    isExpanded: true,
                    //Adding the item of the list
                    items: propertyMeasurementType.map((valueItem) {
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
                    controller: totalArea,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 100,
                  child: DropdownButtonFormField(
                    value: chosenTotalArea,
                    validator: (value) =>
                        value == null ? 'field required' : null,
                    onChanged: (drpVal) {
                      setState(() {
                        chosenTotalArea = drpVal;
                      });
                    },
                    dropdownColor: Colors.grey,
                    iconEnabledColor: Colors.black,
                    hint: Text("Anna"),
                    isExpanded: true,
                    //Adding the item of the list
                    items: propertyMeasurementType.map((valueItem) {
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
              'Property Face: ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              children: [
                DropdownButtonFormField(
                  value: propertyFace,
                  validator: (value) => value == null ? 'field required' : null,
                  onChanged: (drpVal) {
                    setState(() {
                      propertyFace = drpVal;
                    });
                  },
                  dropdownColor: Colors.grey,
                  iconEnabledColor: Colors.black,
                  hint: Text("PRoperty Face"),
                  isExpanded: true,
                  //Adding the item of the list
                  items: propertyFaceList.map((valueItem) {
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
              'Road Distance: ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "eg. 10 ft"),
                  controller: roadDistance,
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
                      child: DropdownButtonFormField(
                        value: roadDistanceType,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (drpVal) {
                          setState(() {
                            roadDistanceType = drpVal;
                          });
                        },
                        dropdownColor: Colors.grey,
                        iconEnabledColor: Colors.black,
                        hint: Text("ft"),
                        isExpanded: true,
                        //Adding the item of the list
                        items: measurementList.map((valueItem) {
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
                      child: DropdownButtonFormField(
                        value: roadType,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (drpVal) {
                          setState(() {
                            roadType = drpVal;
                          });
                        },
                        dropdownColor: Colors.grey,
                        iconEnabledColor: Colors.black,
                        hint: Text("Gravelled"),
                        isExpanded: true,
                        //Adding the item of the list
                        items: roadTypeList.map((valueItem) {
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
                        keyboardType: TextInputType.datetime,
                        controller: builtDate,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Total Floors"),
                        keyboardType: TextInputType.number,
                        controller: totalFloors,
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
                        keyboardType: TextInputType.number,
                        controller: rooms,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Bathroom"),
                        keyboardType: TextInputType.number,
                        controller: bathroom,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Kitchen"),
                        keyboardType: TextInputType.number,
                        controller: kitchen,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Garage"),
                        keyboardType: TextInputType.number,
                        controller: garage,
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
                        keyboardType: TextInputType.number,
                        controller: livingroom,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 130,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Bed Room"),
                        keyboardType: TextInputType.number,
                        controller: bedroom,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        isActive: _currentStep >= 1,
        state: FAStepstate.editing,
      ),
      // Step(
      //   title: Text('Property Amenitites'),
      //   content: Column(
      //     children: <Widget>[
      //       TextFormField(
      //         decoration: InputDecoration(labelText: "New property"),
      //       ),
      //       TextFormField(
      //         decoration: InputDecoration(labelText: "Text property"),
      //       ),
      //       TextFormField(
      //         decoration: InputDecoration(labelText: "Mobile No"),
      //       ),
      //     ],
      //   ),
      //   isActive: _currentStep >= 2,
      //   state: StepState.editing,
      // ),
      //Codes for adding images using milti image picker
      FAStep(
        title: Text(
          'Property Images',
          style: TextStyle(fontSize: 17),
        ),
        content: Container(
          child: Column(
            children: <Widget>[
              //=========================================
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
                child: SingleChildScrollView(
                  child: Container(
                    height: 150,
                    child: buildGridView(),
                  ),
                ),
              ),
              // RaisedButton(
              //   onPressed: _saveImage,
              //   child: Text('Save'),
              // ),
            ],
          ),
        ),
        isActive: _currentStep >= 2,
        state: FAStepstate.editing,
      ),
      FAStep(
        title: Text(
          'Property Pricing',
          style: TextStyle(fontSize: 17),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Property Title"),
              controller: propertyTitle,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Property Description"),
              maxLines: 5,
              controller: propertyDescription,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Property Price"),
              controller: propertyPrice,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Evidence',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            //For sinlge eimage picker for the main image of the post
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  FlatButton.icon(
                    onPressed: loadAssetsv2,
                    icon: Icon(Icons.image),
                    label: Text('Select Evidence'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.black12,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SingleChildScrollView(
                      child: Container(
                        height: 150,
                        child: buildGridView1(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 3,
        state: FAStepstate.editing,
      ),
    ];
    return _steps;
    // Expanded(
    //   child: buildGridView(),
    // ),
  }

  //Setting the data in the addproperty model:
  void sendValidData() {
    addProperty = AddProperty(
        property_name: propertyTitle.text,
        property_description: propertyDescription.text,
        property_price: propertyPrice.text,
        property_status: selectRadio,
        property_type: chosenPropertyType,
        property_address: propertyaddress.text,
        property_city: chosenValue,
        property_located_area: chosenValue,
        built_up_area: builtUpArea.text + " " + chosenBuiltArea,
        property_total_area: totalArea.text + " " + chosenTotalArea,
        property_face: propertyFace,
        road_distance: roadDistance.text + " " + roadDistanceType,
        road_type: roadType,
        bathroom: bathroom.text,
        rooms: rooms.text,
        kitchen: kitchen.text,
        living_room: livingroom.text,
        parking: garage.text,
        built_year: builtDate.text,
        total_floors: totalFloors.text,
        bedroom: bedroom.text,
        longitude: longitude.text,
        latitude: latitude.text);
  }

  //Validation of texfields
  bool validate() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      sendValidData();
      form.save();
      return true;
    }
    return false;
  }

  //Alert dialog
  showAlertDialog(BuildContext dialogContext) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed: () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(dialogContext).pop();
      },
    );
    // set up the AlertDialog
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //Saving single Image file in server:
  Future singleUpload() async {
    String filename = _image.path.split('/').last;
    FormData formData = new FormData.fromMap({
      "image": await MultipartFile.fromFile(_image.path,
          filename: filename, contentType: new MediaType('image', 'png')),
    });
    int propID = await FlutterSession().get("propertyid");
    String token = await FlutterSession().get("token");
    Response response = await dio.post(SINGLE_UPLOAD + "/$propID",
        data: formData,
        options: Options(
          headers: {"authorization": "$token"},
        ));
    if (response.statusCode == 200) {
      EasyLoading.showSuccess('Successfully Stored single image!');
      print(response.data);
    }
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
        String token = await FlutterSession().get("token");
        int propID = await FlutterSession().get("propertyid");
        var response = await dio.post(UPLOAD_URL + "/$propID",
            data: formData,
            options: Options(
              headers: {"authorization": "$token"},
            ));
        if (response.statusCode == 200) {
          EasyLoading.showSuccess('Successfully Stored!');
          print(response.data);
        }
      }
    } else {}
  }
}
