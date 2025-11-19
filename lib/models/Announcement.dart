class Announcement {
  final String id;
  final String title;
  final String content;
  final String category;
  final String priority;
  final String authorId;
  final String authorName;
  final String? imageUrl;
  final bool pinned;
  final DateTime? visibleUntil;
  final DateTime createdAt;
  final DateTime updatedAt;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.priority,
    required this.authorId,
    required this.authorName,
    this.imageUrl,
    required this.pinned,
    this.visibleUntil,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      priority: json['priority'],
      authorId: json['authorId'],
      authorName: json['authorName'],
      imageUrl: json['imageUrl'],
      pinned: json['pinned'] ?? false,
      visibleUntil: json['visibleUntil'] != null ? DateTime.parse(json['visibleUntil']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'category': category,
      'priority': priority,
      'pinned': pinned,
    };
  }
}
