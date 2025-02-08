import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/repo_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  final GitRepo repo;

  DetailsPage({required this.repo});

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('MMM dd, yy • HH:mm').format(dateTime);
  }

  void _launchURL() async {
    final Uri url = Uri.parse(repo.url);
    if (!await launch(url.toString())) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(repo.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(repo.ownerAvatarUrl),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 12),
            Text(
              repo.ownerName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.book,
                            color: Colors.blueGrey, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            repo.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (repo.description.isNotEmpty)
                      Text(
                        repo.description,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black87),
                      )
                    else
                      const Text(
                        "No description available.",
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    const SizedBox(height: 10),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              "${repo.stars}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade800,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                color: Colors.grey, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              formatDateTime(repo.updatedAt),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey.shade700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _launchURL,
              icon: Icon(Icons.open_in_new),
              label: Text("View Repository"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
