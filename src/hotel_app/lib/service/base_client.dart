import 'dart:async';
import 'dart:html';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://localhost:8000';

class BaseClient {
  var client = http.Client();

  //GET request
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future<dynamic> post() async {}
  Future<dynamic> put() async {}
}
