// screens/EventListScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:most_app/helper/EventService.dart';
import 'package:most_app/models/Event.dart';
import 'package:most_app/screens/EventDetailsScreen.dart';
import 'package:most_app/screens/AdminAddEventScreen.dart';
import 'package:most_app/helper/AuthService.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  bool _isLoading = true;
  String _filter = 'upcoming'; // upcoming, past, all

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      await context.read<EventService>().fetchEvents();
    } catch (e) {
      debugPrint('Błąd: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<Event> _getFilteredEvents(List<Event> events) {
    final now = DateTime.now();

    switch (_filter) {
      case 'upcoming':
        return events.where((e) => e.startDate.isAfter(now)).toList()
          ..sort((a, b) => a.startDate.compareTo(b.startDate));
      case 'past':
        return events.where((e) => e.endDate.isBefore(now)).toList()
          ..sort((a, b) => b.startDate.compareTo(a.startDate));
      case 'all':
      default:
        return events..sort((a, b) => a.startDate.compareTo(b.startDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventService = context.watch<EventService>();
    final authService = context.watch<AuthService>();
    final events = _getFilteredEvents(eventService.events);

    final isAdmin = authService.user?.role == 'ADMIN' ||
        authService.user?.role == 'PRZESLOWY';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wydarzenia'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() => _filter = value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'upcoming',
                child: Row(
                  children: [
                    Icon(
                      Icons.upcoming,
                      color: _filter == 'upcoming' ? Colors.blue : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Text('Nadchodzące'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'past',
                child: Row(
                  children: [
                    Icon(
                      Icons.history,
                      color: _filter == 'past' ? Colors.blue : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Text('Zakończone'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'all',
                child: Row(
                  children: [
                    Icon(
                      Icons.list,
                      color: _filter == 'all' ? Colors.blue : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Text('Wszystkie'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadEvents,
        child: events.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 80,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Text(
                _getEmptyMessage(),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return _buildEventCard(event);
          },
        ),
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminAddEventScreen(),
            ),
          );
          if (result == true) _loadEvents();
        },
        backgroundColor: const Color(0xFF1976D2),
        child: const Icon(Icons.add, color: Colors.white),
      )
          : null,
    );
  }

  Widget _buildEventCard(Event event) {
    final now = DateTime.now();
    final isPast = event.endDate.isBefore(now);
    final isToday = event.startDate.day == now.day &&
        event.startDate.month == now.month &&
        event.startDate.year == now.year;
    final isTomorrow = event.startDate.difference(now).inDays == 0 &&
        event.startDate.day == now.day + 1;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isPast ? 1 : 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isToday
              ? Colors.green
              : isTomorrow
              ? Colors.orange
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsScreen(event: event),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Opacity(
          opacity: isPast ? 0.6 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nagłówek
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ikona kalendarza z datą
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isPast
                              ? [Colors.grey, Colors.grey.shade400]
                              : [const Color(0xFF1976D2), Colors.blue.shade300],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getMonthShort(event.startDate.month),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            event.startDate.day.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Tytuł i info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Badges
                          Row(
                            children: [
                              if (isToday)
                                _buildBadge('Dzisiaj', Colors.green),
                              if (isTomorrow)
                                _buildBadge('Jutro', Colors.orange),
                              if (isPast)
                                _buildBadge('Zakończone', Colors.grey),
                            ],
                          ),

                          if (isToday || isTomorrow || isPast)
                            const SizedBox(height: 4),

                          // Tytuł
                          Text(
                            event.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 8),

                          // Godzina
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                '${event.startDate.hour}:${event.startDate.minute.toString().padLeft(2, '0')} - ${event.endDate.hour}:${event.endDate.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          // Lokalizacja
                          if (event.location != null)
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    event.location!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    // Strzałka
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),

                // Opis (jeśli jest)
                if (event.description != null && event.description!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    event.description!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  String _getMonthShort(int month) {
    const months = [
      'STY', 'LUT', 'MAR', 'KWI', 'MAJ', 'CZE',
      'LIP', 'SIE', 'WRZ', 'PAŹ', 'LIS', 'GRU'
    ];
    return months[month - 1];
  }

  String _getEmptyMessage() {
    switch (_filter) {
      case 'upcoming':
        return 'Brak nadchodzących wydarzeń';
      case 'past':
        return 'Brak zakończonych wydarzeń';
      default:
        return 'Brak wydarzeń';
    }
  }
}