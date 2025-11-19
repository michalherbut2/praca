// ============================================
// 3. models/Event.dart
// ============================================
class Event {
  final String id;
  final String title;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String? location;
  final String createdBy;
  final String? przesloId;
  final int? maxParticipants;
  final DateTime createdAt;
  final bool allowRsvp;

  // Zakładam, że backend może (ale nie musi) podać URL obrazka
  final String? imageUrl;

  Event({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    this.location,
    required this.createdBy,
    this.przesloId,
    this.maxParticipants,
    required this.createdAt,
    this.imageUrl,
    required this.allowRsvp,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      location: json['location'],
      createdBy: json['createdBy'],
      przesloId: json['przesloId'],
      maxParticipants: json['maxParticipants'],
      createdAt: DateTime.parse(json['createdAt']),
      imageUrl: json['imageUrl'],
      allowRsvp: json['allowRsvp'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'location': location,
      'createdBy': createdBy,
      'przesloId': przesloId,
      'maxParticipants': maxParticipants,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}