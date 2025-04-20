import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../common/constants.dart';

class ApiService {
  static Future<dynamic> getQuizData({
    String? category,
    String? difficulty,
    int? amount,
  }) async {
    final queryParameters = <String, String>{};

    if (amount != null) {
      queryParameters['amount'] = amount.toString();
    }
    if (category != null && category != '0') {
      queryParameters['category'] = category;
    }
    if (difficulty != null && difficulty != 'any') {
      queryParameters['difficulty'] = difficulty;
    }
    queryParameters['type'] = 'multiple';

    final queryString = queryParameters.entries
        .map((entry) => '${entry.key}=${Uri.encodeQueryComponent(entry.value)}')
        .join('&');

    final url = Uri.parse('${Constants.baseUrl}?$queryString');

    debugPrint('URL: $url');

    final response = await http.get(url);
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }
}
