import 'package:flutter/material.dart';
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
  int currentPage = 1;
  int totalPages = 10; // Assume 10 pages for now; update dynamically later
  int perPage = 30;

  @override
  void initState() {
    super.initState();
    loadRepos();
  }

  Future<void> loadRepos() async {
    final dbData = DatabaseData();
    final apiService = DataFromAPI();

    try {
      print("Fetching data from API for page $currentPage");
      //repos = await apiService.fetchGitReposFromAPI(page: currentPage, perPage: perPage);
      // repos = await apiService.fetchGitReposFromAPI();
      final response = await apiService.fetchGitReposFromAPI(page: currentPage, perPage: perPage);
      repos = response['repos'];
      totalPages = response['totalPages'];
      await dbData.insertRepos(repos);
    } catch (e) {
      print("Fetching data from database");
      repos = await dbData.getRepos();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void onPageChanged(int page) {
    if (page >= 1 && page <= totalPages) {
      print("In page changed $page");
      setState(() {
        currentPage = page;
        _isLoading = true;
      });
      loadRepos();
    }
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
          : Column(
        children: [
          Expanded(
            child: RefreshIndicator(
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
          ),
          _buildPaginationControls(),
        ],
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPage > 2)
            _pageButton(1),

          if (currentPage > 3)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text("..."),
            ),

          if (currentPage > 1)
            _pageButton(currentPage - 1),

          _pageButton(currentPage, isSelected: true),

          if (currentPage < totalPages)
            _pageButton(currentPage + 1),

          if (currentPage < totalPages - 2)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text("..."),
            ),

          if (currentPage == totalPages - 1 || currentPage == totalPages - 2) // Show lastPage - 1 properly
            _pageButton(totalPages - 1),

          // if (currentPage < totalPages - 1)
          //   _pageButton(totalPages),

          if (currentPage < totalPages) _pageButton(totalPages)
        ],
      ),
    );
  }

  Widget _pageButton(int page, {bool isSelected = false}) {
    return InkWell(
      onTap: () => onPageChanged(page),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.blueAccent),
          ),
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
