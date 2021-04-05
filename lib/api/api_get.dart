import 'package:http/http.dart' as http;
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
  static const String url =
      'http://10.0.2.2:3000/v1/property/getPropertyDetails';

  static Future<List<Datum>> getProperty() async {
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
}
