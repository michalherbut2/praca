import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:most_app/styles/Colors.dart';
import 'package:most_app/widgets/ScreenHeader.dart';
import 'package:most_app/widgets/ShowIntentionSummaryDialog.dart';


class OrderIntentionScreen extends StatefulWidget {
  const OrderIntentionScreen({super.key});

  @override
  State<OrderIntentionScreen> createState() => _OrderIntentionScreenState();
}

class _OrderIntentionScreenState extends State<OrderIntentionScreen> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime? _selectedDay;
  final List<DateTime> _busyDays = [
    DateTime(2024, 3, 7),
    DateTime(2024, 3, 8),
    DateTime(2024, 3, 10),
    DateTime(2024, 3, 11),
    DateTime(2024, 3, 12),
    DateTime(2024, 3, 13),
    DateTime(2024, 3, 14),
    DateTime(2024, 3, 15),
    DateTime(2024, 3, 17),
    DateTime(2024, 3, 18),
    DateTime(2024, 3, 19),
    DateTime(2024, 3, 20),
    DateTime(2024, 3, 22),
    DateTime(2024, 3, 24),
    DateTime(2024, 3, 26),
    DateTime(2024, 3, 27),
    DateTime(2024, 3, 28),
    DateTime(2024, 3, 29),
    DateTime(2024, 3, 31),
  ];
  final List<DateTime> _availableDays = [
    DateTime(2024, 3, 21),
    DateTime(2024, 3, 25),
  ];

  final List<bool> _faqExpanded = [false, false];

  @override
  void initState() {
    super.initState();
    // Initialize date formatting for Polish locale before rendering the calendar
    initializeDateFormatting('pl_PL', null);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ScreenHeader(title: "ZAMÓW INTENCJĘ"),
          Text(
            'W celu dodania intencji należy:',
            style: TextStyle(
              color: blueColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          _descListItem('wybrać odpowiedni dzień z kalendarza,'),
          _descListItem('wprowadzić dane zamawiającego,'),
          _descListItem('wprowadzić treść intencji,'),
          _descListItem('zamówienie potwierdzić przyciskiem.'),
          const SizedBox(height: 8),
          Text(
            'Gdy intencja zostanie dodana, należy oczekiwać jej zatwierdzenia (zostanie wysłana informacja na podany e-mail).\n\n'
            'Msze Święte w intencjach tutaj dodanych mogą być odprawiane w poniedziałek, środę, czwartek i piątek o godzinie 19:00, we wtorek i niedzielę o godzinie 19:30.',
            style: TextStyle(
              color: blueColor,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 18),
          _label('Imię zamawiającego:'),
          _textField(_nameController),
          _label('Nazwisko zamawiającego:'),
          _textField(_surnameController),
          _label('Adres e-mail:'),
          _textField(_emailController,
              keyboardType: TextInputType.emailAddress),
          _label('Treść intencji:'),
          _textField(_contentController, maxLines: 3),
          const SizedBox(height: 18),
          _calendarSection(),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 220,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 19),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                ),
                onPressed: () {
                  // Tu obsłuż zamówienie
                  showIntentionSummaryDialog(
                    context,
                    name: _nameController.text,
                    email: _emailController.text,
                    content: _contentController.text,
                    onOrder: () {
                      showIntentionAddedDialog(context,
                          onOk: () {/* np. przejdź dalej */});
                    },
                    onEdit: () {/* wróć do formularza, nic nie rób */},
                  );
                },
                child: const Text('ZAMAWIAM'),
              ),
            ),
          ),
          const SizedBox(height: 18),
          _faqSection(),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _descListItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 8),
        Text('•', style: TextStyle(color: blueColor, fontSize: 18)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: blueColor, fontSize: 15),
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 2),
      child: Text(
        text,
        style: TextStyle(
          color: blueColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _textField(TextEditingController controller,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(color: blueColor, fontSize: 15),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: blueColor),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: blueColor, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _calendarSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: blueColor),
      ),
      padding: const EdgeInsets.all(6),
      child: TableCalendar(
        firstDay: DateTime(2024, 3, 1),
        lastDay: DateTime(2024, 3, 31),
        focusedDay: _selectedDay ?? DateTime(2024, 3, 21),
        locale: 'pl_PL',
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle:
              TextStyle(color: blueColor, fontWeight: FontWeight.bold, fontSize: 17),
          leftChevronIcon: Icon(Icons.chevron_left, color: blueColor),
          rightChevronIcon: Icon(Icons.chevron_right, color: blueColor),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: blueColor, fontWeight: FontWeight.bold),
          weekendStyle: TextStyle(color: blueColor, fontWeight: FontWeight.bold),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            final isBusy = _busyDays.any((d) =>
                d.year == day.year && d.month == day.month && d.day == day.day);
            final isAvailable = _availableDays.any((d) =>
                d.year == day.year && d.month == day.month && d.day == day.day);
            if (isBusy) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Text('${day.day}',
                    style: const TextStyle(color: Colors.black)),
              );
            }
            if (isAvailable) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Text('${day.day}',
                    style: const TextStyle(color: Colors.white)),
              );
            }
            return null;
          },
          selectedBuilder: (context, day, focusedDay) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(0),
                border: Border.all(color: blueColor, width: 2),
              ),
              child: Text('${day.day}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            );
          },
        ),
        selectedDayPredicate: (day) =>
            _selectedDay != null &&
            day.year == _selectedDay!.year &&
            day.month == _selectedDay!.month &&
            day.day == _selectedDay!.day,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
          });
        },
        calendarStyle: CalendarStyle(
          cellMargin: EdgeInsets.zero,
          cellPadding: EdgeInsets.zero,
          todayDecoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }

  Widget _faqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Częste pytania',
          style: TextStyle(
            color: blueColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Theme(
          data: Theme.of(context).copyWith(cardColor: Colors.white),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _faqExpanded[index] = isExpanded;
              });
            },
            elevation: 2,
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) => ListTile(
                  title: Text(
                    'Ile kosztuje intencja Mszy Świętej?',
                    style: TextStyle(
                        color: blueColor, fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Text(
                    'Intencja Mszy Świętej nie ma ustalonej ceny. Dobrowolną ofiarę można przekazać podczas zamawiania.',
                    style: TextStyle(color: blueColor, fontSize: 14),
                  ),
                ),
                isExpanded: _faqExpanded[0],
                canTapOnHeader: true,
              ),
              ExpansionPanel(
                headerBuilder: (context, isExpanded) => ListTile(
                  title: Text(
                    'Przykładowe intencje',
                    style: TextStyle(
                        color: blueColor, fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Text(
                    'Za zdrowie i Boże błogosławieństwo dla rodziny.\nZa zmarłego Jana Kowalskiego.\nO szczęśliwą operację dla Anny.',
                    style: TextStyle(color: blueColor, fontSize: 14),
                  ),
                ),
                isExpanded: _faqExpanded[1],
                canTapOnHeader: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
