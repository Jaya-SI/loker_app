import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loker/model/model.dart';

import '../common/shared_code.dart';

Future<List<DropdownCategory>?> fetchCategory() async {
  var response =
      await http.get(Uri.parse("${SharedCode.baseUrl}/api/hrd/get-category"));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    if (jsonResponse != null) {
      var dataDropdownCategory = jsonResponse
          .map((data) =>  DropdownCategory.fromJson(data))
          .toList();
      return dataDropdownCategory;
    } else {
      throw Exception('Data Category Kosong');
    }
  }
}
