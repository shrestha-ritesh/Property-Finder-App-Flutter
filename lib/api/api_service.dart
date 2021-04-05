//Importing flutter http package for api
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:propertyfinder/config/config.dart';
import 'package:propertyfinder/models/add_property_model.dart';
import 'dart:convert';
import 'package:propertyfinder/models/login_module.dart';
import 'package:propertyfinder/models/register_module.dart';

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
}
