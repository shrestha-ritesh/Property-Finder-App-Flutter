import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:propertyfinder/api/api_service.dart';
import 'package:propertyfinder/appBar.dart';
import 'package:propertyfinder/config/config.dart';
import 'package:propertyfinder/extra/maps.dart';
import 'package:propertyfinder/models/Property.dart';
import 'package:propertyfinder/models/add_property_model.dart';

class EditPropertyPage extends StatefulWidget {
  final Datum property;
  EditPropertyPage({@required this.property});
  @override
  _EditPropertyPageState createState() => _EditPropertyPageState();
}

class _EditPropertyPageState extends State<EditPropertyPage> {
  //For Single image picker:
  File _image;
  final picker = ImagePicker();
  var session = FlutterSession();
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
  String chosenPropertyArea;
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
  List dropdownContents = ["Kathmandu", "Bhaktapur", "Lalitpur", "Hetauda"];
  List dropdownContents2 = [
    "Newroad area",
    "Kamal Pokhari area",
    "Thapathali area",
    "Maitighar area"
  ];
  List propertyFaceList = ["East", "West", "North", "South"];
  List roadTypeList = ["Gravelled", "Paved", "Black Toppe", "Alley"];
  List measurementList = ["feet", "meter"];

  setSelectedRadio(String val) {
    setState(() {
      selectRadio = val;
      print(widget.property.propertyId);
    });
  }

  // For Selecting image function:
  Future selectImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  //Getting the data from the another class:
  getPropertyData() {
    setState(() {
      selectRadio = widget.property.propertyStatus;
      latitude.text = widget.property.latitude;
      longitude.text = widget.property.longitude;
      builtDate.text = widget.property.otherDetails.builtYear;
      totalFloors.text = widget.property.otherDetails.totalFloors;
      rooms.text = widget.property.otherDetails.rooms;
      bathroom.text = widget.property.otherDetails.bathroom;
      builtUpArea.text = widget.property.builtUpArea;
      totalArea.text = widget.property.propertyTotalArea;
      roadDistance.text = widget.property.roadDistance;
      kitchen.text = widget.property.otherDetails.kitchen;
      garage.text = widget.property.otherDetails.parking;
      livingroom.text = widget.property.otherDetails.livingRoom;
      propertyTitle.text = widget.property.propertyName;
      propertyDescription.text = widget.property.propertyDescription;
      propertyPrice.text = widget.property.propertyPrice.toString();
      bedroom.text = widget.property.otherDetails.bedroom;
      propertyaddress.text = widget.property.propertyAddress;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getPropertyData();
    });

    selectRadio = '';

    //For easy loading (can be removed mark *)
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });

    print(widget.property);

    //EasyLoading.showSuccess('Use in initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: homeAppBar(context, "Edit Property"),
      body: SingleChildScrollView(
        child: Form(
          key: globalFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              children: [
                Text(
                  "Basic Property Details: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 17,
                  child: Divider(
                    height: 9,
                  ),
                ),
                _buildBody(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Additional Property Details: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 17,
                  child: Divider(
                    height: 9,
                  ),
                ),
                propertyDetails(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Property Images: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 17,
                  child: Divider(
                    height: 9,
                  ),
                ),
                propertyImage(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Property Pricing: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 17,
                  child: Divider(
                    height: 10,
                  ),
                ),
                propertyPricing(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.grey[300],
                    onPressed: () {
                      if (validate()) {
                        session.set("propertyid", widget.property.propertyId);
                        print(addProperty.toJson());
                        ApiService apiService = new ApiService();
                        apiService
                            .updateProperty(addProperty)
                            .then((value) async {
                          if (value.success == 1) {
                            await _saveImage();
                          } else {
                            print(value.error);
                          }
                          final snackbar = SnackBar(
                            content: Text("Successfully Added!"),
                          );
                          scaffoldKey.currentState.showSnackBar(snackbar);
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.send,
                          color: Colors.blueGrey[600],
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            "Edit Data",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Add Property:
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 15, right: 15),
      child: Column(
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
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Center(
                  child: DropdownButtonFormField(
                    value: chosenPropertyArea,
                    validator: (value) =>
                        value == null ? 'property city required' : null,
                    onChanged: (drpVal) {
                      setState(() {
                        chosenPropertyArea = drpVal;
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
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Center(
                  child: DropdownButtonFormField(
                    value: chosenValue,
                    validator: (value) =>
                        value == null ? 'located Area required' : null,
                    onChanged: (drpVal) {
                      setState(() {
                        chosenValue = drpVal;
                      });
                    },
                    dropdownColor: Colors.grey,
                    hint: Text("Select any areas"),
                    isExpanded: true,
                    //Adding the item of the list
                    items: dropdownContents2.map((valueItem) {
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                          color: Colors.cyan[100],
                        ),
                      ),
                      color: Colors.lightBlue[300],
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
                            validator: (value) =>
                                value == "" ? 'latitude required' : null,
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
                            validator: (value) =>
                                value == "" ? 'Longitude required' : null,
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
    );
  }

  Widget propertyDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
      child: Column(
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
                  validator: (value) =>
                      value == "" ? 'Buit-up Area required' : null,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 100,
                child: DropdownButtonFormField(
                  value: chosenBuiltArea,
                  validator: (value) => value == null ? 'field required' : null,
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
                  decoration: InputDecoration(
                      labelText: "Total Area", hintText: "e.g. 12"),
                  validator: (value) =>
                      value == "" ? 'total area required' : null,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 100,
                child: DropdownButtonFormField(
                  value: chosenTotalArea,
                  validator: (value) => value == null ? 'field required' : null,
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
                validator: (value) =>
                    value == "" ? 'Road Distance required' : null,
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
                      validator: (value) =>
                          value == null ? 'Road Distance required' : null,
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
    );
  }

  Widget propertyImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
      child: Container(
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
                  child: (images.length <= 0)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select the picture of the property",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        )
                      : buildGridView(),
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
    );
  }

  Widget propertyPricing() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "Property Title"),
            controller: propertyTitle,
            validator: (value) =>
                value == "" ? 'Property Title required' : null,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Property Description"),
            validator: (value) =>
                value == "" ? 'Porperty Description is required' : null,
            maxLines: 5,
            controller: propertyDescription,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Property Price"),
            controller: propertyPrice,
            validator: (value) =>
                value == "" ? 'property price is required' : null,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  //Setting the data in the addproperty model:
  void sendValidData() {
    addProperty = AddProperty(
        property_name: (propertyTitle.text) == ""
            ? widget.property.propertyName
            : propertyTitle.text,
        property_description: (propertyDescription.text) == ""
            ? widget.property.propertyDescription
            : propertyDescription.text,
        property_price: (propertyPrice.text) == ""
            ? widget.property.propertyPrice.toString()
            : propertyPrice.text,
        property_status:
            (selectRadio) == "" ? widget.property.propertyStatus : selectRadio,
        property_type: (chosenPropertyType) == ""
            ? widget.property.propertyType
            : chosenPropertyType,
        property_address: (propertyaddress.text) == null
            ? widget.property.propertyAddress
            : propertyaddress.text,
        property_city: (chosenPropertyArea) == null
            ? widget.property.propertyCity
            : chosenPropertyArea,
        property_located_area: (chosenValue) == ""
            ? widget.property.propertyLocatedArea
            : chosenValue,
        built_up_area: (builtUpArea.text) == ""
            ? widget.property.builtUpArea
            : builtUpArea.text + " " + chosenBuiltArea,
        property_total_area: (totalArea.text) == ""
            ? widget.property.propertyTotalArea
            : totalArea.text + " " + chosenTotalArea,
        property_face: (propertyFace.isEmpty)
            ? widget.property.propertyFace
            : propertyFace,
        road_distance: (roadDistance.text) == ""
            ? widget.property.roadDistance
            : roadDistance.text + " " + roadDistanceType,
        road_type: (roadType) == "" ? widget.property.roadType : roadType,
        bathroom: (bathroom.text) == ""
            ? widget.property.otherDetails.bathroom
            : bathroom.text,
        rooms: (rooms.text) == ""
            ? widget.property.otherDetails.rooms
            : rooms.text,
        kitchen: (kitchen.text) == ""
            ? widget.property.otherDetails.kitchen
            : kitchen.text,
        living_room: (livingroom.text) == ""
            ? widget.property.otherDetails.livingRoom
            : livingroom.text,
        parking: (garage.text) == ""
            ? widget.property.otherDetails.parking
            : garage.text,
        built_year: (builtDate.text) == ""
            ? widget.property.otherDetails.builtYear
            : builtDate.text,
        total_floors: (totalFloors.text) == ""
            ? widget.property.otherDetails.totalFloors
            : totalFloors.text,
        bedroom: (bedroom.text) == ""
            ? widget.property.otherDetails.bedroom
            : bedroom.text,
        longitude:
            (longitude.text) == "" ? widget.property.longitude : longitude.text,
        latitude:
            (latitude.text) == "" ? widget.property.latitude : latitude.text);
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
      title: Text("Delete Property"),
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
