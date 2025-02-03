import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popular/screens/repoDetailsPage.dart';
import '../local database/sqflite.dart';
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
          :
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: repos.length,
          itemBuilder: (context, index) {
            final repo = repos[index];
            return GitRepoTile(repo: repo);
          },
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

class GitRepoTile extends StatelessWidget {
  final GitRepo repo;

  const GitRepoTile({Key? key, required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
        side: BorderSide(color: Colors.grey.shade300, width: 1), // Subtle border
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6), // Space between cards
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(repo.ownerAvatarUrl),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    repo.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            if (repo.description.isNotEmpty)
              Text(
                repo.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey.shade700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orangeAccent, size: 18),
                    SizedBox(width: 5),
                    Text(
                      "${repo.stars}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade800,
                      ),
                    ),
                  ],
                ),

                Text(
                  "Updated ${_formatDate(repo.updatedAt)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blueGrey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM dd, yyyy').format(date); // Example: Jan 31, 2024
  }
}
