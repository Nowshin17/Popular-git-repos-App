import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/repo_model.dart';
import '../screens/repoDetailsPage.dart';


class GitRepoTile extends StatelessWidget {
  final GitRepo repo;

  const GitRepoTile({Key? key, required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(repo: repo),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
          side: BorderSide(
              color: Colors.grey.shade300, width: 1), // Subtle border
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
                    onBackgroundImageError: (_, __) =>
                    const AssetImage('assets/gitIMG.png'),
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.blueGrey, size: 18),
                      const SizedBox(width: 5),
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
      ),
    );
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM dd, yyyy').format(date);
  }
}