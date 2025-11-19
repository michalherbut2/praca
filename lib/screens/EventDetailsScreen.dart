// screens/EventDetailsScreen.dart
import 'package:flutter/material.dart';
import 'package:most_app/helper/AuthService.dart';
import 'package:most_app/screens/AdminEditEventScreen.dart';
import 'package:provider/provider.dart';
import 'package:most_app/helper/EventService.dart';
import 'package:most_app/models/Event.dart';
import 'package:most_app/models/EventRsvp.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  EventRsvp? _myRsvp;
  Map<String, int> _attendees = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final eventService = context.read<EventService>();

    try {
      final rsvp = await eventService.getMyRsvp(widget.event.id);
      final attendees = await eventService.getAttendees(widget.event.id);

      if (mounted) {
        setState(() {
          _myRsvp = rsvp;
          _attendees = attendees;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Błąd ładowania: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleRsvp(String status) async {
    setState(() => _isLoading = true);

    try {
      await context.read<EventService>().rsvpToEvent(widget.event.id, status);
      await _loadData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_getStatusMessage(status)),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Błąd: $e'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  String _getStatusMessage(String status) {
    switch (status) {
      case 'ATTENDING':
        return '✅ Zapisano: Będę uczestniczyć';
      case 'NOT_ATTENDING':
        return '❌ Zapisano: Nie będę uczestniczyć';
      case 'MAYBE':
        return '❓ Zapisano: Może będę';
      default:
        return 'Zapisano';
    }
  }
  bool _canEdit() {
    final auth = context.read<AuthService>();
    return auth.user?.role == 'ADMIN' ||
        auth.user?.id == widget.event.createdBy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Szczegóły wydarzenia'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        actions: [
          if (_canEdit())
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminEditEventScreen(event: widget.event),
                  ),
                );
                if (result == true) Navigator.pop(context);
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header z tłem
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF1976D2),
                    Colors.blue.shade300,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_myRsvp != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getRsvpColor(_myRsvp!.status),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _getRsvpLabel(_myRsvp!.status),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Informacje o wydarzeniu
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Data i godzina
                  _buildInfoCard(
                    icon: Icons.calendar_today,
                    title: 'Data rozpoczęcia',
                    content: _formatDateTime(widget.event.startDate),
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 12),

                  _buildInfoCard(
                    icon: Icons.calendar_today,
                    title: 'Data zakończenia',
                    content: _formatDateTime(widget.event.endDate),
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 12),

                  // Lokalizacja
                  if (widget.event.location != null)
                    _buildInfoCard(
                      icon: Icons.location_on,
                      title: 'Lokalizacja',
                      content: widget.event.location!,
                      color: Colors.red,
                    ),

                  const SizedBox(height: 12),

                  // Max uczestników
                  if (widget.event.maxParticipants != null)
                    _buildInfoCard(
                      icon: Icons.people,
                      title: 'Limit miejsc',
                      content: '${_attendees['attending'] ?? 0} / ${widget.event.maxParticipants}',
                      color: Colors.orange,
                    ),

                  const SizedBox(height: 24),

                  // Opis
                  if (widget.event.description != null && widget.event.description!.isNotEmpty) ...[
                    const Text(
                      'Opis',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.event.description!,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Statystyki uczestników
                  const Text(
                    'Uczestnicy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Będzie',
                          _attendees['attending'] ?? 0,
                          Colors.green,
                          Icons.check_circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatCard(
                          'Nie będzie',
                          _attendees['notAttending'] ?? 0,
                          Colors.red,
                          Icons.cancel,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatCard(
                          'Może',
                          _attendees['maybe'] ?? 0,
                          Colors.orange,
                          Icons.help,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Przyciski RSVP
                  const Text(
                    'Czy będziesz uczestniczyć?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Duże przyciski RSVP
                  _buildRsvpButton(
                    label: 'Będę uczestniczyć',
                    status: 'ATTENDING',
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),

                  const SizedBox(height: 12),

                  _buildRsvpButton(
                    label: 'Nie będę uczestniczyć',
                    status: 'NOT_ATTENDING',
                    icon: Icons.cancel,
                    color: Colors.red,
                  ),

                  const SizedBox(height: 12),

                  _buildRsvpButton(
                    label: 'Nie wiem jeszcze',
                    status: 'MAYBE',
                    icon: Icons.help_outline,
                    color: Colors.orange,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRsvpButton({
    required String label,
    required String status,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _myRsvp?.status == status;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () => _handleRsvp(status),
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? color : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black87,
          elevation: isSelected ? 4 : 0,
          side: BorderSide(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    final months = [
      'stycznia', 'lutego', 'marca', 'kwietnia', 'maja', 'czerwca',
      'lipca', 'sierpnia', 'września', 'października', 'listopada', 'grudnia'
    ];

    return '${dt.day} ${months[dt.month - 1]} ${dt.year}, ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Color _getRsvpColor(String status) {
    switch (status) {
      case 'ATTENDING':
        return Colors.green;
      case 'NOT_ATTENDING':
        return Colors.red;
      case 'MAYBE':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getRsvpLabel(String status) {
    switch (status) {
      case 'ATTENDING':
        return '✓ Będę';
      case 'NOT_ATTENDING':
        return '✗ Nie będę';
      case 'MAYBE':
        return '? Może';
      default:
        return 'Brak odpowiedzi';
    }
  }
}