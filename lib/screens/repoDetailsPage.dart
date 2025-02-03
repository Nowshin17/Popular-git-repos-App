import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/repo_model.dart';


class DetailsPage extends StatelessWidget {
  final GitRepo repo;

  DetailsPage({required this.repo});

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('MM-dd-yy HH:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(repo.ownerAvatarUrl),
              ),
            ),
            SizedBox(height: 16),
            Text("Owner: ${repo.ownerName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Description: ${repo.description}", style: TextStyle(fontSize: 16)),
            Text("Last Updated: ${formatDateTime(repo.updatedAt)}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Stars: ⭐ ${repo.stars}", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
