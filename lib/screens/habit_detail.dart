import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/habit_controller.dart';
import '../models/habit.dart';
import '../widgets/habit_progress.dart';
import '../widgets/streak.dart';


class HabitDetailScreen extends StatelessWidget {
  final String habitId;

  const HabitDetailScreen({super.key, required this.habitId});

  @override
  Widget build(BuildContext context) {
    final HabitController habitController = Get.find();
    final habit = habitController.habits.firstWhere((h) => h.id == habitId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Details', style: GoogleFonts.poppins()),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditDialog(habitController, habit),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteDialog(habitController, habit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Text(
                habit.icon,
                style: const TextStyle(fontSize: 60),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              habit.name,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${habit.frequency} Habit',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Get.theme.hintColor,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreakCounter(
                  streakCount: habitController.getCurrentStreak(habit.id),
                ),
                Column(
                  children: [
                    Text(
                      'Completion Rate',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Text(
                      '${(habitController.getHabitCompletionRate(habit.id) * 100).toStringAsFixed(1)}%',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            HabitProgress(
              completionRate:
              habitController.getHabitCompletionRate(habit.id),
            ),
            const SizedBox(height: 30),
            _buildCompletionHistory(habitController, habit),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionHistory(HabitController controller, Habit habit) {
    final recentDates = habit.completedDates.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Completions',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        if (recentDates.isEmpty)
          Text(
            'No completions yet',
            style: GoogleFonts.poppins(color: Get.theme.hintColor),
          ),
        ...recentDates.map((date) => ListTile(
          leading: const Icon(Icons.check_circle, color: Colors.green),
          title: Text(date),
        )),
      ],
    );
  }

  void _showEditDialog(HabitController controller, Habit habit) {
    final nameController = TextEditingController(text: habit.name);
    String selectedFrequency = habit.frequency;
    String selectedIcon = habit.icon;

    Get.dialog(
      AlertDialog(
        title: Text('Edit Habit', style: GoogleFonts.poppins()),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Habit Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedFrequency,
                items: ['Daily', 'Weekly', 'Monthly']
                    .map((freq) => DropdownMenuItem(
                  value: freq,
                  child: Text(freq),
                ))
                    .toList(),
                onChanged: (value) => selectedFrequency = value!,
                decoration: const InputDecoration(
                  labelText: 'Frequency',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text('Select Icon', style: GoogleFonts.poppins()),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: ['🏃‍♂️', '📚', '💧', '🍎', '🧘‍♂️', '✍️', '🎯']
                    .map((icon) => GestureDetector(
                  onTap: () => selectedIcon = icon,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selectedIcon == icon
                          ? Get.theme.primaryColor.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: selectedIcon == icon
                            ? Get.theme.primaryColor
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(icon, style: const TextStyle(fontSize: 24)),
                  ),
                ))
                    .toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.updateHabit(
                id: habit.id,
                name: nameController.text,
                frequency: selectedFrequency,
                icon: selectedIcon,
              );
              Get.back();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(HabitController controller, Habit habit) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Habit', style: GoogleFonts.poppins()),
        content: Text(
          'Are you sure you want to delete "${habit.name}"?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteHabit(habit.id);
              Get.back();
              Get.back();
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}