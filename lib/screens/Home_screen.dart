import 'package:flutter/material.dart';
import '../models/repo_model.dart';
import '../service_page/service.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final GitHubService _githubService = GitHubService();
  List<GitRepo> _repos = [];

  @override
  void initState() {
    super.initState();
    _loadRepos();
  }

  Future<void> _loadRepos() async {
    try {
      List<GitRepo> repos = await _githubService.fetchGitRepos();
      setState(() => _repos = repos);
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("POPULAR GIT REPOSITORIES"),
          centerTitle: true,
         // backgroundColor:Colors.grey,
    ),
    body: SingleChildScrollView()
    );
  }
}
