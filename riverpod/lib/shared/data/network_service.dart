import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';

class NetworkService {

  // Public Properties
  static Map<String, String> headers = {
    'content-type': 'application/json; charset=utf-8',
  };

  // Public methods
  static Future<Map> postRequest({required String endpoint, required Map<String, dynamic> body}) async {
    final uri = Uri.https(Constants.kHost, endpoint);
    final results = await http.post(uri, headers: headers, body: jsonEncode(body));

    return json.decode(results.body);
  }
}