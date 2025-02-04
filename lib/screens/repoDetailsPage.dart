import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/repo_model.dart';

class DetailsPage extends StatelessWidget {
  final GitRepo repo;

  DetailsPage({required this.repo});

  /// 🕒 Formats date & time
  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('MMM dd, yyyy • HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(repo.name, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 🟢 Owner Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(repo.ownerAvatarUrl),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 12),

            /// 🔹 Owner Name
            Text(
              repo.ownerName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),

            /// 📌 Repository Information Card
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
                    /// 🏷 Repo Name
                    Row(
                      children: [
                        Icon(Icons.book, color: Colors.blueGrey, size: 20),
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

                    /// 📝 Description
                    if (repo.description.isNotEmpty)
                      Text(
                        repo.description,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      )
                    else
                      Text(
                        "No description available.",
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
                      ),

                    const SizedBox(height: 10),
                    Divider(),

                    /// ⭐ Stars & Last Updated
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
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
                            Icon(Icons.access_time, color: Colors.grey, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              formatDateTime(repo.updatedAt),
                              style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade700),
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

            /// 🌍 Open Repository Button
            ElevatedButton.icon(
              onPressed: () {
                // Open repository link
                print("Opening Repo: ${repo.url}");
              },
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
