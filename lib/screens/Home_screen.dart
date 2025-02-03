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
        title: const Text("POPULAR GIT REPOSITORIES"),
        centerTitle: true,
        // backgroundColor:Colors.grey,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: repos.length,
              itemBuilder: (context, index) {
                final repo = repos[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(repo.ownerAvatarUrl),
                    //onBackgroundImageError: (_, __) => AssetImage('assets/default_avatar.png'),
                  ),
                  title: Text(repo.name),
                  subtitle: Text(repo.description),
                  trailing: Text("⭐ ${repo.stars}"),
                  onTap: () {

                  },
                );
              },
            ),
    );
  }
}
