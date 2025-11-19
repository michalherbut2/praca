// 4. models/EventRsvp.dart
class EventRsvp {
  final String id;
  final String eventId;
  final String userId;
  final String status; // ATTENDING, NOT_ATTENDING, MAYBE

  EventRsvp({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.status,
  });

  factory EventRsvp.fromJson(Map<String, dynamic> json) {
    return EventRsvp(
      id: json['id'],
      eventId: json['eventId'],
      userId: json['userId'],
      status: json['status'],
    );
  }
}
