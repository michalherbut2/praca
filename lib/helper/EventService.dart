// ============================================
// 2. helper/EventService.dart
// ============================================
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:most_app/models/Event.dart';
import 'package:most_app/helper/AuthService.dart';
import 'package:most_app/models/EventRsvp.dart';

class EventService extends ChangeNotifier {
  final AuthService _authService;

  List<Event> _events = [];
  List<Event> get events => _events;

  EventService(this._authService);

  String get _baseUrl => 'http://192.168.1.100:8080/api/events'; // Android emulator
  // String get _baseUrl => 'http://localhost:8080/api/events'; // iOS simulator

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_authService.token != null)
      'Authorization': 'Bearer ${_authService.token}',
  };

  // Pobierz wszystkie wydarzenia
  Future<void> fetchEvents() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        _events = data.map((json) => Event.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Błąd pobierania wydarzeń: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Błąd w fetchEvents: $e');
      rethrow;
    }
  }

  // Pobierz nadchodzące wydarzenia
  Future<List<Event>> fetchUpcomingEvents() async {
    await fetchEvents();
    final now = DateTime.now();
    return _events.where((event) => event.startDate.isAfter(now)).toList()
      ..sort((a, b) => a.startDate.compareTo(b.startDate));
  }

  // Utwórz wydarzenie (Admin/Przęsłowy)
  Future<void> createEvent({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required bool allowRsvp,
    String? location,
    int? maxParticipants,

  }) async {
    try {
      final body = {
        'title': title,
        'description': description,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        if (location != null && location.isNotEmpty) 'location': location,
        if (maxParticipants != null) 'maxParticipants': maxParticipants,
        'allowRsvp': allowRsvp,

      };
      print("Wysyłam Event: $body");

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers,
        body: json.encode(body),
      );
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 201) {
        await fetchEvents(); // Odśwież listę
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Błąd tworzenia wydarzenia');
      }
    } catch (e) {
      debugPrint('Błąd w createEvent: $e');
      rethrow;
    }
  }

  // Usuń wydarzenie (Admin/Twórca)
  Future<void> deleteEvent(String eventId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$eventId'),
        headers: _headers,
      );

      if (response.statusCode == 204) {
        _events.removeWhere((event) => event.id == eventId);
        notifyListeners();
      } else {
        throw Exception('Błąd usuwania wydarzenia: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Błąd w deleteEvent: $e');
      rethrow;
    }
  }

  Future<void> updateEvent({
    required String eventId,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    String? location,
    int? maxParticipants,
  }) async {
    try {
      final body = {
        'title': title,
        'description': description,
        'startDate': startDate.toUtc().toIso8601String(),
        'endDate': endDate.toUtc().toIso8601String(),
        if (location != null) 'location': location,
        if (maxParticipants != null) 'maxParticipants': maxParticipants,
      };

      final response = await http.put(
        Uri.parse('$_baseUrl/$eventId'),
        headers: _headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        await fetchEvents();
      } else {
        throw Exception('Błąd aktualizacji');
      }
    } catch (e) {
      debugPrint('Błąd updateEvent: $e');
      rethrow;
    }
  }



  Future<void> rsvpToEvent(String eventId, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$eventId/rsvp'),
        headers: _headers,
        body: json.encode({'status': status}),
      );

      if (response.statusCode == 200) {
        await fetchEvents();
      } else {
        throw Exception('Błąd zapisu');
      }
    } catch (e) {
      debugPrint('Błąd rsvpToEvent: $e');
      rethrow;
    }
  }

  Future<EventRsvp?> getMyRsvp(String eventId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$eventId/rsvp/my'),
        headers: _headers,
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return EventRsvp.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      debugPrint('Błąd getMyRsvp: $e');
      return null;
    }
  }

  Future<Map<String, int>> getAttendees(String eventId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$eventId/attendees'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'attending': data['attending'],
          'notAttending': data['notAttending'],
          'maybe': data['maybe'],
          'total': data['total'],
        };
      }
      return {};
    } catch (e) {
      debugPrint('Błąd getAttendees: $e');
      return {};
    }
  }
}