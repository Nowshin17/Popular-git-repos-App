import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import '../models/repo_model.dart';

class DataFromAPI {
  static const String baseUrl = baseURL;

  Future<List<GitRepo>> fetchGitReposFromAPI() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      print("Response: 200");
      final data = json.decode(response.body);
      print(data);
      final List<dynamic> items = data['items'];
      return items.map((repo) => GitRepo.fromJson(repo)).toList();
    } else {
      throw Exception("Failed to fetch repositories");
    }
  }
}
