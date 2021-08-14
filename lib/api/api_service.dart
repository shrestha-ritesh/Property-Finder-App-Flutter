//Importing flutter http package for api

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:propertyfinder/config/config.dart';
import 'package:propertyfinder/models/Property.dart';
import 'package:propertyfinder/models/add_property_model.dart';
import 'package:propertyfinder/models/change_password_model.dart';
import 'dart:convert';
import 'package:propertyfinder/models/login_module.dart';
import 'package:propertyfinder/models/register_module.dart';
import 'package:propertyfinder/models/report_model.dart';
import 'package:propertyfinder/models/requestModel.dart';
import 'package:propertyfinder/models/searchRequest.dart';
import 'package:propertyfinder/models/sendFavourites.dart';
import 'package:propertyfinder/models/userProfileUpdate.dart';

class ApiService {
  //creating the method of future type with the reponse type of LoginResponse Model
  // ignore: missing_return
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = BASE_URL + "users/login"; //api url

    final response = await http.post(url, body: requestModel.toJson());
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return LoginResponseModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //creating Regsiter Re
  Future<RegisterResponse> register(RegisterRequestModel requestModel) async {
    String url = BASE_URL + "users/register"; //api url

    final response = await http.post(url, body: requestModel.toJson());
    print(response);
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return RegisterResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // Creating API Add Room API
  Future<AddPropertyResponse> addproperty(AddProperty addPropertyModel) async {
    String token = await FlutterSession().get("token");
    int userId = await FlutterSession().get("id");
    String url =
        "http://10.0.2.2:3000/v1/property/addProperty/$userId"; //api url
    print('This is token =>' + token);
    print('This is token =>' + userId.toString());
    final response = await http.post(
      url,
      headers: {
        "authorization": "$token",
      },
      body: addPropertyModel.toJson(),
    );
    print(response.body);
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return AddPropertyResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //Sending the inspection request to the server:
  Future<UserRequestResponse> userInspection(UserRequest userRequest) async {
    int propId = await FlutterSession().get("property_id");
    int userId = await FlutterSession().get("id");
    String url = BASE_URL + "request/inspection/$propId/$userId";
    print('This is userId ==> $userId');
    print('This is property_Id ==> $propId');

    final response = await http.post(
      url,
      body: userRequest.toJson(),
    );
    print("This is response body" + response.body);
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return UserRequestResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //For sending the saved properties id;
  Future<FavouriteSaveResponse> savedFavourites(
      FavouriteSave favouriteSave) async {
    String url = BASE_URL + "saveProperties/favourites/post";
    String token = await FlutterSession().get("token");

    final response = await http.post(
      url,
      headers: {
        "authorization": "$token",
      },
      body: favouriteSave.toJson(),
    );
    print("This is the final response " + response.body);
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return FavouriteSaveResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //For removing the same saved properties _id
  Future<FavouriteSaveResponse> removeFavourite(
      FavouriteSave favouriteSave) async {
    int prop_id = await FlutterSession().get("removeFavPropId");
    int userId = await FlutterSession().get("id");

    String token = await FlutterSession().get("token");

    String url = BASE_URL + "saveProperties/favourites/delete/$prop_id/$userId";

    final response = await http.delete(
      url,
      headers: {
        "authorization": "$token",
      },
    );
    print("This is the final response " + response.body);
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return FavouriteSaveResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Datum>> searchProperty(SearchRequest searchRequest) async {
    String token = await FlutterSession().get("token");

    String url = BASE_URL + "search/getSearchData";

    final response = await http.post(
      url,
      headers: {
        "authorization": "$token",
      },
      body: searchRequest.toJson(),
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        final body = response.body;
        final searchedProperties = propertyFromJson(body);
        List<Datum> searchProp = searchedProperties.data;
        print(searchProp[0]);
        return searchProp;
      }
    } catch (e) {
      // throw Exception(e);
      return List<Datum>();
    }
  }

  //For Updating the user profile:
  Future<UpdateProfileResponse> updateProfile(
      UpdateProfile updateProfile) async {
    int user_id = await FlutterSession().get("id");
    String token = await FlutterSession().get("token");
    String url = BASE_URL + 'users/updateUser/$user_id';

    final response = await http.patch(url,
        headers: {
          "authorization": "$token",
        },
        body: updateProfile.toJson());
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return UpdateProfileResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //For Evidence image
  Dio dio = Dio();
  saveEvidenceImage(var images) async {
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

        //Image post
        String token = await FlutterSession().get("token");
        int propID = await FlutterSession().get("propertyid");
        var response = await dio.post(EVIDENCE_URL + "/$propID",
            data: formData,
            options: Options(
              headers: {"authorization": "$token"},
            ));
        if (response.statusCode == 200) {
          EasyLoading.showSuccess('eVIDENCE STORED!');
          print(response.data);
        }
      }
    } else {}
  }

  //Requesting the patch method of the serverwith specific URL:
  Future<UpdateResponse> updateProperty(AddProperty addProperty) async {
    String token = await FlutterSession().get("token");
    int property_id = await FlutterSession().get("propertyid");

    String url = BASE_URL + "property/updateListedProperty/$property_id";

    final response = await http.patch(
      url,
      headers: {
        "authorization": "$token",
      },
      body: addProperty.toJson(),
    );
    print(response.body);
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return UpdateResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //For removing the listed property
  Future<DeleteResponse> removeListedProperty() async {
    int prop_id = await FlutterSession().get("prop_id");

    String token = await FlutterSession().get("token");

    String url = BASE_URL + "property/deleteProperty/$prop_id";
    print(url);

    final response = await http.delete(
      url,
      headers: {
        "authorization": "$token",
      },
    );
    print("This is the final response " + response.body);
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return DeleteResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // //Sending the inspection request to the server:
  // Future<UserRequestResponse> userInspection(UserRequest userRequest) async {
  //   int propId = await FlutterSession().get("property_id");
  //   int userId = await FlutterSession().get("id");
  //   String url = BASE_URL + "request/inspection/$propId/$userId";
  //   print('This is userId ==> $userId');
  //   print('This is property_Id ==> $propId');

  //   final response = await http.post(
  //     url,
  //     body: userRequest.toJson(),
  //   );
  //   print("This is response body" + response.body);
  //   try {
  //     if (response.statusCode == 200 || response.statusCode == 400) {
  //       return UserRequestResponse.fromJson(json.decode(response.body));
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  //Sending the report request to the server:

  //Sending the post request to the server:
  Future<ReportResponse> addReportProperty(ReportRequest reportRequest) async {
    int propId = await FlutterSession().get("property_id");
    int userId = await FlutterSession().get("id");
    String token = await FlutterSession().get("token");
    String url = BASE_URL + "property/addReport/$propId/$userId";
    print('This is the user ID: $userId');
    print('This is the propertyID $propId');

    final response = await http.post(
      url,
      headers: {
        "authorization": "$token",
      },
      body: reportRequest.toJson(),
    );
    print("This is the reponse Body" + response.body);
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return ReportResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //Api connection for change password:

  Future<ChangePasswordResponse> changePasswordApi(
      ChangePasswordRequest changePasswordRequest) async {
    int userId = await FlutterSession().get("id");
    String token = await FlutterSession().get("token");
    String url = BASE_URL + "users/changepassword/$userId";
    print('This is user ID: $userId');

    final response = await http.post(
      url,
      headers: {
        "authorization": "$token",
      },
      body: changePasswordRequest.toJson(),
    );
    print("Response body change password: " + response.body);
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return ChangePasswordResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
