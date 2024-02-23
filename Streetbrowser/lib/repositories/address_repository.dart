import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/address.dart';
import '../model/company.dart';

class AddressRepository {
  Future<List<Address>> fetchAddresses(String query) async {
    final http.Response response = await http
        .get(Uri.parse('https://api-adresse.data.gouv.fr/search/?q=$query'));
    if (response.statusCode == 200) {
      final List<Address> addresses = [];
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey("features")) {
        final List<dynamic> features = json['features'];
        for (var feature in features) {
          final address = Address.fromGeoJson(feature);
          addresses.add(address);
        }
      }
      return addresses;
    } else {
      throw Exception('Failed to load addresses');
    }
  }
}
