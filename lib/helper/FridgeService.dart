// ============================================
// 2. helper/FridgeService.dart
// ============================================
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:most_app/models/FridgeItem.dart';
import 'package:most_app/helper/AuthService.dart';

class FridgeService extends ChangeNotifier {
  final AuthService _authService;

  List<FridgeItem> _items = [];
  List<FridgeItem> get items => _items;

  FridgeService(this._authService);

  String get _baseUrl => 'http://192.168.1.100:8080/api/fridge';

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_authService.token != null)
      'Authorization': 'Bearer ${_authService.token}',
  };

  Future<void> fetchItems() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        _items = data.map((json) => FridgeItem.fromJson(json)).toList();

        // Sortuj: przeterminowane -> wygasające -> reszta
        _items.sort((a, b) {
          if (a.isExpired() && !b.isExpired()) return -1;
          if (!a.isExpired() && b.isExpired()) return 1;
          if (a.isExpiringSoon() && !b.isExpiringSoon()) return -1;
          if (!a.isExpiringSoon() && b.isExpiringSoon()) return 1;
          return b.createdAt.compareTo(a.createdAt);
        });

        notifyListeners();
      } else {
        throw Exception('Błąd pobierania produktów');
      }
    } catch (e) {
      debugPrint('Błąd fetchItems: $e');
      rethrow;
    }
  }

  Future<void> addItem({
    required String name,
    required double quantity,
    required String unit,
    required String category,
    DateTime? expiryDate,
    bool isOpened = false,
    String? notes,
  }) async {
    try {
      final body = {
        'name': name,
        'quantity': quantity,
        'unit': unit,
        'category': category,
        if (expiryDate != null) 'expiryDate': expiryDate.toIso8601String().split('T')[0],
        'isOpened': isOpened,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      };

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers,
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        await fetchItems();
      } else {
        throw Exception('Błąd dodawania produktu');
      }
    } catch (e) {
      debugPrint('Błąd addItem: $e');
      rethrow;
    }
  }

  Future<void> deleteItem(String itemId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$itemId'),
        headers: _headers,
      );

      if (response.statusCode == 204) {
        _items.removeWhere((item) => item.id == itemId);
        notifyListeners();
      } else {
        throw Exception('Błąd usuwania produktu');
      }
    } catch (e) {
      debugPrint('Błąd deleteItem: $e');
      rethrow;
    }
  }
}