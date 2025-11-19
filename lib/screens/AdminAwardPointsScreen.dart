// ============================================
// 9. screens/AdminAwardPointsScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:most_app/helper/PointsService.dart';
import 'package:most_app/helper/AuthService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminAwardPointsScreen extends StatefulWidget {
  const AdminAwardPointsScreen({super.key});

  @override
  State<AdminAwardPointsScreen> createState() => _AdminAwardPointsScreenState();
}

class _AdminAwardPointsScreenState extends State<AdminAwardPointsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pointsController = TextEditingController();
  final _reasonController = TextEditingController();

  List<Map<String, dynamic>> _users = [];
  String? _selectedUserId;
  bool _isLoading = false;
  bool _isLoadingUsers = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      print('Ładowanie użytkowników...');
      final auth = context.read<AuthService>();
      print('Ładowanie użytkowników z tokenem: ${auth.token}');
      final response = await http.get(
        Uri.parse('http://192.168.1.100:8080/api/users'), // Musisz dodać endpoint
        headers: {
          'Authorization': 'Bearer ${auth.token}',
        },
      );
print('Odpowiedź status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _users = data.map((u) => {
            'id': u['id'],
            'name': '${u['firstName']} ${u['lastName']}',
            'points': u['points'],
          }).toList();
          _isLoadingUsers = false;
        });
      }
      print('Użytkownicy załadowani: $_users');
    } catch (e) {
      debugPrint('Błąd: $e');
      setState(() => _isLoadingUsers = false);
      print('Błąd podczas ładowania użytkowników: $e');
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wybierz użytkownika')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await context.read<PointsService>().awardPoints(
        userId: _selectedUserId!,
        amount: int.parse(_pointsController.text),
        reason: _reasonController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Punkty przyznane')),
        );
        // Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Błąd: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Przyznaj Punkty'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: _isLoadingUsers
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Wybierz użytkownika',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedUserId,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person),
                ),
                // items: _users.map((user) {
                //   return DropdownMenuItem(
                //     value: user['id'],
                //     child: Text('${user['name']} (${user['points']} pkt)'),
                //   );
                // }).toList(),
                items: _users.map<DropdownMenuItem<String>>((user) { // <-- POPRAWKA 1: Mówimy, jaki typ zwracamy
                  return DropdownMenuItem<String>( // <-- POPRAWKA 2: Jawnie typujemy DropdownMenuItem
                    value: user['id'] as String, // <-- POPRAWKA 3: Rzutujemy (cast) 'id' na String
                    child: Text('${user['name']} (${user['points']} pkt)'),
                  );
                }).toList(),
                onChanged: (v) => setState(() => _selectedUserId = v),
                validator: (v) => v == null ? 'Wybierz użytkownika' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pointsController,
                decoration: InputDecoration(
                  labelText: 'Liczba punktów *',
                  hintText: 'np. 10',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.stars),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Wymagane';
                  if (int.tryParse(v) == null) return 'Liczba';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'Powód *',
                  hintText: 'np. Pozmywanie po kolacji',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (v) => v == null || v.isEmpty ? 'Wymagane' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Przyznaj Punkty', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}