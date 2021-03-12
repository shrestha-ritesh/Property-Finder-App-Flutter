//Importing flutter http package for api
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:propertyfinder/models/login_module.dart';
import 'package:propertyfinder/models/register_module.dart';

class ApiService {
  //creating the method of future type with the reponse type of LoginResponse Model
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "http://192.168.1.16:3000/v1/users/login"; //api url

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
    String url = "http://192.168.1.16:3000/v1/users/register"; //api url

    final response = await http.post(url, body: requestModel.toJson());
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return RegisterResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
