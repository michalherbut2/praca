import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:most_app/helper/AuthService.dart';
import 'package:most_app/models/Announcement.dart';
import 'package:http/http.dart' as http;

class AnnouncementsService with ChangeNotifier {
  final AuthService authService;

  AnnouncementsService({required this.authService});

  final String baseUrl = 'http://192.168.1.100:8080/api/announcements';

  // Lista ogłoszeń w pamięci
  List<Announcement> _announcements = [];
  List<Announcement> get announcements => _announcements;

  // --- Pobierz listę ogłoszeń i odśwież listę w serwisie ---
  Future<void> fetchAnnouncements() async {
    // final token = authService.token;
    // if (token == null) {
    //   throw Exception("Brak tokena. Zaloguj się.");
    // }

    final url = Uri.parse(baseUrl);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // final List<dynamic> data = jsonDecode(response.body);
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      _announcements =
          data.map((json) => Announcement.fromJson(json)).toList();
      notifyListeners(); // powiadom widgety
    } else {
      throw Exception("Błąd pobierania ogłoszeń: ${response.body}");
    }
  }

  // --- Dodaj nowe ogłoszenie ---
  Future<Announcement> createAnnouncement({
    required String title,
    required String content,
    required String category,
    required String priority,
    required bool pinned,
  }) async {
    final token = authService.token;
    if (token == null) {
      throw Exception("Brak tokena. Zaloguj się.");
    }

    // Backend powinien sam dodać 'authorId' i 'authorName' na podstawie tokena,
    // więc wysyłamy tylko te dane, które pochodzą z formularza.
    final body = jsonEncode({
      'title': title,
      'content': content,
      'category': category,
      'priority': priority,
      'pinned': pinned,
    });

    final url = Uri.parse(baseUrl);
    // POPRAWKA: Było 'createAnnouncement', zmieniłem na 'http.post'
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final newAnnouncement = Announcement.fromJson(data);
      _announcements.insert(0, newAnnouncement);
      notifyListeners();
      return newAnnouncement;
    } else {
      throw Exception("Błąd tworzenia ogłoszenia: ${response.body}");
    }
  }
}
