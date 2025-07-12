import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:table_calendar/table_calendar.dart';import '../controllers/habit_controller.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final HabitController habitController = Get.find();
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar View', style: GoogleFonts.poppins()),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Get.theme.primaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Get.theme.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: GoogleFonts.poppins(),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              final dateKey = habitController.formatDateKey(_selectedDay);
              final habitsForDate = habitController.habits
                  .where((habit) => habit.completedDates.contains(dateKey))
                  .toList();

              return ListView.builder(
                itemCount: habitController.habits.length,
                itemBuilder: (context, index) {
                  final habit = habitController.habits[index];
                  final isCompleted = habit.completedDates.contains(dateKey);

                  return CheckboxListTile(
                    title: Text(habit.name),
                    subtitle: Text(habit.frequency),
                    secondary: Text(habit.icon, style: TextStyle(fontSize: 24)),
                    value: isCompleted,
                    onChanged: (value) {
                      habitController.toggleHabitCompletion(
                        habit.id,
                        _selectedDay,
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}