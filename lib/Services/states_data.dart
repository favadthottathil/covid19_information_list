import 'dart:convert';

import 'package:covid_19_application/Model/all_countries_covid_status/all_countries_covid_status.dart';
import 'package:covid_19_application/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class StatusService {
  Future<AllCovidStatus> fetchData() async {
    final reponse = await http.get(Uri.parse(ApiUrls.worldStatesApi));

    if (reponse.statusCode == 200) {
      var data = jsonDecode(reponse.body);
      return AllCovidStatus.fromJson(data);
    } else {
      throw Exception('error');
    }
  }
}
