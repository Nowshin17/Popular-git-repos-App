import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/repo_model.dart';

class DataFromAPI {
  static const String defaultQuery = "Android";
  String query = defaultQuery;

  Future<Map<String, dynamic>> fetchGitReposFromAPI(
      {String query = "Android", int page = 1, int perPage = 30}) async {
    String apiUrl =
        "https://api.github.com/search/repositories?q=$query&sort=stars&page=$page";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
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

  void updateQuery(String newQuery) {
    query = newQuery.isNotEmpty ? newQuery : defaultQuery;
  }

  int _parseLastPage(String? linkHeader) {
    if (linkHeader == null) return 1;
    RegExp regExp = RegExp(r'&page=(\d+)>; rel="last"');
    Match? match = regExp.firstMatch(linkHeader);
    return match != null ? int.parse(match.group(1)!) : 1;
  }
}
