import '../model/company.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class PreferencesRepository {
  Future<void> saveCompanies(List<Company> companies) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listJson = [];
    for (final Company company in companies) {
      listJson.add(jsonEncode(company.toJson()));
    }
    prefs.setStringList('companies', listJson);
  }

  Future<List<Company>> loadCompanies() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? companiesJson = prefs.getStringList('companies');
  if (companiesJson == null) {
    return [];
  }

  return companiesJson.map((companyJson) => Company.fromJson(jsonDecode(companyJson))).toList();
}

}
