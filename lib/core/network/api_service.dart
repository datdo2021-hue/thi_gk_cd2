import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/model/article.dart';

class ApiService {
  static const String _url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Article>> fetchNews() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Article.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}