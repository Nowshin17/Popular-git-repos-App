import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import '../models/repo_model.dart';

class DataFromAPI {
  static const String baseUrl = baseURL;

  Future<Map<String, dynamic>> fetchGitReposFromAPI({int page = 1, int perPage = 30}) async {
    final response = await http.get(Uri.parse("$baseUrl&page=$page"));

    if (response.statusCode == 200) {
      print("Response: 200");
      final data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      final repos = items.map((repo) => GitRepo.fromJson(repo)).toList();

      String? linkHeader = response.headers['link'];
      int totalPages = _parseLastPage(linkHeader);

      return {'repos': repos, 'totalPages': totalPages};
    } else {
      throw Exception("Failed to fetch repositories");
    }
  }

  int _parseLastPage(String? linkHeader) {
    if (linkHeader == null) return 1;
    RegExp regExp = RegExp(r'&page=(\d+)>; rel="last"');
    Match? match = regExp.firstMatch(linkHeader);
    return match != null ? int.parse(match.group(1)!) : 1;
  }
}