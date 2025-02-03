import 'package:flutter/material.dart';
import '../local database/sqlite.dart';
import '../models/repo_model.dart';
import '../service_page/service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GitRepo> repos = [];
  @override
  void initState() {
    super.initState();
    loadRepos();
  }

  Future<void> loadRepos() async {
    final dbHelper = DatabaseHelper();
    final apiService = GitHubService();

    try {
      repos = await apiService.fetchGitRepos();
      print(repos);
     await dbHelper.insertRepos(repos);
    } catch (e) {

    }

  }

  // Future<void> _loadRepos() async {
  //   try {
  //     List<GitRepo> repos = await _githubService.fetchGitRepos();
  //     await _dbHelper.insertRepos(repos);
  //     setState(() => _repos = repos);
  //   } catch (e) {
  //     // If API fails, load from local DB
  //     // List<GitRepo> repos = await _dbHelper.getRepos();
  //     // setState(() => _repos = repos);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("POPULAR GIT REPOSITORIES"),
          centerTitle: true,
          // backgroundColor:Colors.grey,
        ),
        body: SingleChildScrollView());
  }
}
