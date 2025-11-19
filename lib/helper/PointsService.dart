// ============================================
// 8. helper/PointsService.dart
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:most_app/models/PointsTransaction.dart';
import 'package:most_app/helper/AuthService.dart';

class PointsService extends ChangeNotifier {
  final AuthService _authService;

  List<PointsTransaction> _transactions = [];
  List<PointsTransaction> get transactions => _transactions;

  PointsService(this._authService);

  String get _baseUrl => 'http://192.168.1.100:8080/api/points';

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_authService.token != null)
      'Authorization': 'Bearer ${_authService.token}',
  };

  Future<void> fetchMyTransactions() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/me'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        _transactions = data.map((json) => PointsTransaction.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Błąd fetchMyTransactions: $e');
      rethrow;
    }
  }

  Future<void> awardPoints({
    required String userId,
    required int amount,
    required String reason,
  }) async {
    try {
      final body = {
        'userId': userId,
        'amount': amount,
        'reason': reason,
      };

      final response = await http.post(
        Uri.parse('$_baseUrl/award'),
        headers: _headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Success
      } else {
        throw Exception('Błąd przyznawania punktów');
      }
    } catch (e) {
      debugPrint('Błąd awardPoints: $e');
      rethrow;
    }
  }
}