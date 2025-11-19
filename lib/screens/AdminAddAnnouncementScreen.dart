// screens/AdminAddAnnouncementScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:most_app/helper/AnnouncementService.dart';

class AdminAddAnnouncementScreen extends StatefulWidget {
  const AdminAddAnnouncementScreen({super.key});

  @override
  State<AdminAddAnnouncementScreen> createState() => _AdminAddAnnouncementScreenState();
}

class _AdminAddAnnouncementScreenState extends State<AdminAddAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  String _category = 'GENERAL';
  String _priority = 'NORMAL';
  bool _pinned = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submitAnnouncement() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final announcementService = context.read<AnnouncementsService>();

      await announcementService.createAnnouncement(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _category,
        priority: _priority,
        pinned: _pinned,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Ogłoszenie dodane'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Błąd: $e'),
            backgroundColor: Colors.red,
          ),
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
        title: const Text('Dodaj Ogłoszenie'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tytuł
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Tytuł *',
                  hintText: 'np. Rekolekcje Adwentowe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.title),
                ),
                maxLength: 200,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tytuł jest wymagany';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Treść
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Treść *',
                  hintText: 'Wpisz treść ogłoszenia...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
                maxLength: 2000,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Treść jest wymagana';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Kategoria
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  labelText: 'Kategoria',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.category),
                ),
                items: const [
                  DropdownMenuItem(value: 'GENERAL', child: Text('📋 Ogólne')),
                  DropdownMenuItem(value: 'IMPORTANT', child: Text('⚠️ Ważne')),
                  DropdownMenuItem(value: 'EVENTS', child: Text('📅 Wydarzenia')),
                  DropdownMenuItem(value: 'SPIRITUALITY', child: Text('🙏 Duchowość')),
                ],
                onChanged: (value) {
                  setState(() => _category = value!);
                },
              ),

              const SizedBox(height: 16),

              // Priorytet
              DropdownButtonFormField<String>(
                value: _priority,
                decoration: InputDecoration(
                  labelText: 'Priorytet',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.flag),
                ),
                items: const [
                  DropdownMenuItem(value: 'LOW', child: Text('🟢 Niski')),
                  DropdownMenuItem(value: 'NORMAL', child: Text('🟡 Normalny')),
                  DropdownMenuItem(value: 'HIGH', child: Text('🔴 Wysoki')),
                ],
                onChanged: (value) {
                  setState(() => _priority = value!);
                },
              ),

              const SizedBox(height: 16),

              // Przypnij
              Card(
                child: SwitchListTile(
                  title: const Text('Przypnij na górze'),
                  subtitle: const Text('Ogłoszenie będzie zawsze pierwsze'),
                  value: _pinned,
                  onChanged: (value) {
                    setState(() => _pinned = value);
                  },
                  secondary: Icon(
                    _pinned ? Icons.push_pin : Icons.push_pin_outlined,
                    color: _pinned ? Colors.blue : Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Przycisk Submit
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitAnnouncement,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    'Opublikuj Ogłoszenie',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}