class GitRepo {
  final String name;
  final String description;
  final String url;
  final int stars;
  final String ownerName;
  final String ownerAvatarUrl;
  final String updatedAt;
  final String keyword;
  final int pageno;
  final int totalpage;

  GitRepo({
    required this.name,
    required this.description,
    required this.url,
    required this.stars,
    required this.ownerName,
    required this.ownerAvatarUrl,
    required this.updatedAt,
    required this.keyword,
    required this.pageno,
    required this.totalpage,
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
      keyword: json['keyword'] ?? '',
      pageno: json['pageno'] ?? 1,
      totalpage: json['totalpage'] ?? 1,
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
      'keyword': keyword,
      'pageno': pageno,
      'totalpage': totalpage,
    };
  }
}
