import 'dart:convert';
import 'package:github_search/models/repositorie.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final http.Client httpClient = http.Client();

  static const BASE_URL = 'https://api.github.com';
  static const PER_PAGE = 10;

  static Future searchRepositories(
      {required String seachName, int page = 1}) async {
    var response;
    var url = Uri.parse(
        '$BASE_URL/search/repositories?q=$seachName&per_page=$PER_PAGE&page=$page');
    print(url);
    try {
      response = await http.get(url);
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
      print('Response body: ${json.decode(utf8.decode(response.bodyBytes))}');
      final jsonData = utf8.decode(response.bodyBytes);
      final repositories = repositorieFromJson(jsonData);
      return repositories;
    } else {
      throw Exception("Нет соединения");
    }
  }
}
