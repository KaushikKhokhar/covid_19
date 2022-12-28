import 'dart:convert';

import 'package:covid_19/app_url.dart';
import 'package:http/http.dart' as http;

import '../model/world_information_model.dart';

class WorldInformationServices {
  Future<WorldInformationModel> fetchWorldInformation() async {
    var uri = Uri.parse(AppUrl.worldInformationApi);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('This is the response $data');
      return WorldInformationModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}
