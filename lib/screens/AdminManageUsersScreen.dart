// 9. AdminManageUsersScreen.dart - ZARZĄDZANIE UŻYTKOWNIKAMI
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:most_app/helper/AuthService.dart';

class AdminManageUsersScreen extends StatefulWidget {
  const AdminManageUsersScreen({super.key});

  @override
  State<AdminManageUsersScreen> createState() => _AdminManageUsersScreenState();
}

class _AdminManageUsersScreenState extends State<AdminManageUsersScreen> {
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final auth = context.read<AuthService>();
      final response = await http.get(
        Uri.parse('http://192.168.1.100:8080/api/users'),
        headers: {'Authorization': 'Bearer ${auth.token}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _users = data.map((u) => u as Map<String, dynamic>).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Błąd: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _changeRole(String userId, String currentRole) async {
    final newRole = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Zmień rolę'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'GOSC', 'MOSTOWIAK', 'PODPRZESLOWY', 'PRZESLOWY', 'ADMIN'
          ].map((role) {
            return RadioListTile<String>(
              title: Text(role),
              value: role,
              groupValue: currentRole,
              onChanged: (value) => Navigator.pop(context, value),
            );
          }).toList(),
        ),
      ),
    );

    if (newRole != null && newRole != currentRole && mounted) {
      try {
        final auth = context.read<AuthService>();
        final response = await http.put(
          Uri.parse('http://10.0.2.2:8080/api/users/$userId/role'),
          headers: {
            'Authorization': 'Bearer ${auth.token}',
            'Content-Type': 'application/json',
          },
          body: json.encode({'role': newRole}),
        );

        if (response.statusCode == 200) {
          _loadUsers();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Zmieniono rolę')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Błąd: $e')),
        );
      }
    }
  }

  Future<void> _deleteUser(String userId, String name) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usuń konto'),
        content: Text('Czy na pewno usunąć konto użytkownika $name?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Usuń'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      try {
        final auth = context.read<AuthService>();
        final response = await http.delete(
          Uri.parse('http://10.0.2.2:8080/api/users/$userId'),
          headers: {'Authorization': 'Bearer ${auth.token}'},
        );

        if (response.statusCode == 204) {
          _loadUsers();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Usunięto konto')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Błąd: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zarządzanie Kontami'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  user['firstName'][0] + user['lastName'][0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text('${user['firstName']} ${user['lastName']}'),
              subtitle: Text('${user['email']}\n${user['role']} • ${user['points']} pkt'),
              isThreeLine: true,
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'role',
                    child: Text('Zmień rolę'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Usuń konto', style: TextStyle(color: Colors.red)),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'role') {
                    _changeRole(user['id'], user['role']);
                  } else if (value == 'delete') {
                    _deleteUser(user['id'], '${user['firstName']} ${user['lastName']}');
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}