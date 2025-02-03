class GitRepo {
  final String name;
  final String description;
  final String url;
  final int stars;
  final String ownerName;
  final String ownerAvatarUrl;
  final String updatedAt;

  GitRepo({
    required this.name,
    required this.description,
    required this.url,
    required this.stars,
    required this.ownerName,
    required this.ownerAvatarUrl,
    required this.updatedAt,
  });

  factory GitRepo.fromJson(Map<String, dynamic> json) {
    return GitRepo(
      name: json['name'] ?? 'No Name',
      description: json['description'] ?? 'No Description',
      url: json['html_url'],
      stars: json['stargazers_count'],
      ownerName: json['owner']['login'],
      ownerAvatarUrl: json['owner']['avatar_url'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'url': url,
      'stars': stars,
      'owner_name': ownerName,
      'owner_avatar_url': ownerAvatarUrl,
      'updated_at': updatedAt,
    };
  }
}
