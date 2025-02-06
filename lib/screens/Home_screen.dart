import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popular/screens/repoDetailsPage.dart';
import '../local database/sqflite.dart';
import '../models/repo_model.dart';
import '../service_page/service.dart';
import '../widgets/gitRepoTile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GitRepo> repos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRepos();
  }

  Future<void> loadRepos() async {
    final dbData = DatabaseData();
    final apiService = DataFromAPI();

    try {
      print("data from api");
      repos = await apiService.fetchGitReposFromAPI();
      await dbData.insertRepos(repos);
    } catch (e) {
      print("data from database");
      repos = await dbData.getRepos();
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "POPULAR GIT REPOSITORIES",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadRepos,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: repos.length,
                  itemBuilder: (context, index) {
                    final repo = repos[index];
                    return GitRepoTile(repo: repo);
                  },
                ),
              ),
            ),
      // ListView.builder(
      //         itemCount: repos.length,
      //         itemBuilder: (context, index) {
      //           final repo = repos[index];
      //           return ListTile(
      //
      //             leading: CircleAvatar(
      //               backgroundImage: NetworkImage(repo.ownerAvatarUrl),
      //               //onBackgroundImageError: (_, __) => AssetImage('assets/default_avatar.png'),
      //             ),
      //             title: Text(repo.name),
      //             textColor: Colors.blueGrey,
      //             subtitle: Text(repo.description),
      //             trailing: Text("⭐ ${repo.stars}"),
      //             onTap: () {
      //
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(builder: (context) => DetailsPage(repo: repo)),
      //               );
      //
      //             },
      //           );
      //         },
      //       ),
    );
  }
}
