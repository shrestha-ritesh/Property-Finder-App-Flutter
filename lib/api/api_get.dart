import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:propertyfinder/config/config.dart';
import 'package:propertyfinder/models/Favourites.dart';
import 'package:propertyfinder/models/User.dart';
import '../models/Property.dart';
// class GetApi {
//   Future<String> getImageData() async {
//     final String url = "http://10.0.2.2:3000/v1/uploadImages/getimage/19";
//     var response = await http.get(
//       //Encode the url
//       Uri.encodeFull(url),
//       //Only accepts json response
//       headers: {"Accept": "application/json"},
//     );
//     return response;
//   }
// }

class Services {
  var session = FlutterSession();

  static Future<List<Datum>> getProperty() async {
    const String url = 'http://10.0.2.2:3000/v1/property/getPropertyDetails';
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // print(response.body);
        final body = response.body;
        // print(body.length);
        final properties = propertyFromJson(body);
        List<Datum> property = properties.data;
        // List property = properties.data.toString();
        print(property[0].propertyAddress);
        return property;
      } else {
        print('Khali cha hai');
        // return List<Property>();
      }
    } catch (e) {
      return List<Datum>();
    }
  }

  //For getting Favourites detail:
  static const String url1 =
      'http://10.0.2.2:3000/v1/saveProperties/favourites/getData';
  static Future<List<FavouritesId>> getFavouritesId() async {
    try {
      final response = await http.get(url1);
      if (response.statusCode == 200) {
        final body = response.body;
        final favourites = favouritesDataFromJson(body);
        List<FavouritesId> favourite = favourites.data;
        print(favourite[0].favouriteId);
        return favourite;
      } else {
        print('Error');
      }
    } catch (e) {
      return List<FavouritesId>();
    }
  }

  //Getting the Property data for the favourites of the individual user:
  static Future<List<Datum>> getFavouriteProperty() async {
    int userId = await FlutterSession().get("id");
    String url = BASE_URL + "saveProperties/favourites/getprop/$userId";
    print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = response.body;
        final favouriteProperties = propertyFromJson(body);
        List<Datum> favProperty = favouriteProperties.data;
        print(favProperty[0]);
        return favProperty;
      }
    } catch (e) {
      return List<Datum>();
    }
  }

  //Getting the listed property data based on the user listings:
  static Future<List<Datum>> getuserListedProperty() async {
    int userId = await FlutterSession().get("id");
    String url = BASE_URL + "property/getlistedProperty/$userId";
    print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = response.body;
        final userListedProperty = propertyFromJson(body);
        List<Datum> userListProperty = userListedProperty.data;
        return userListProperty;
      }
    } catch (e) {
      return List<Datum>();
    }
  }

  //Getting the user data from the api
  static Future<List<User>> getUserData() async {
    int userId = await FlutterSession().get("id");
    String url = BASE_URL + "users/profile/$userId";
    print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = response.body;
        final userData = usersFromJson(body);
        List<User> userLists = userData.data;
        return userLists;
      }
    } catch (e) {
      return List<User>();
    }
  }
}
