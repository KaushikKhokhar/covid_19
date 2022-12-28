// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:covid_19/app_url.dart';
import 'package:covid_19/countries/model/countries_model.dart';
import 'package:http/http.dart' as http;

class CountriesServices {
  Future<List<CountriesModel>> getCountriesData() async {
    List<CountriesModel> countriesList = [];
    var uri = Uri.parse(AppUrl.countries);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      for (Map i in data) {
        countriesList.add(CountriesModel.fromJson(i as Map<String, dynamic>));
      }
      return countriesList;
    } else {
      return countriesList;
    }
  }
}
