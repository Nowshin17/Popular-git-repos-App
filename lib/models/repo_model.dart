class GitRepo {
  final String name;
  final String description;
  final String url;
  final int stars;

  GitRepo({
    required this.name,
    required this.description,
    required this.url,
    required this.stars,
  });

  factory GitRepo.fromJson(Map<String, dynamic> json) {
    return GitRepo(
      name: json['name'] ?? 'No Name',
      description: json['description'] ?? 'No Description',
      url: json['html_url'],
      stars: json['stargazers_count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'url': url,
      'stars': stars,
    };
  }
}
