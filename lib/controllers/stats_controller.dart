import 'package:get/get.dart';

import 'habit_controller.dart';

class StatsController extends GetxController {
  final HabitController habitController = Get.find();

  int get totalHabits => habitController.habits.length;

  int get completedToday {
    final todayKey = habitController.formatDateKey(DateTime.now());
    return habitController.habits
        .where((habit) => habit.completedDates.contains(todayKey))
        .length;
  }

  int get longestStreak {
    if (habitController.habits.isEmpty) return 0;
    return habitController.habits
        .map((habit) => habitController.getCurrentStreak(habit.id))
        .reduce((a, b) => a > b ? a : b);
  }

  double get overallCompletionRate {
    if (habitController.habits.isEmpty) return 0.0;
    final rates = habitController.habits
        .map((habit) => habitController.getHabitCompletionRate(habit.id));
    return rates.reduce((a, b) => a + b) / rates.length;
  }

  Map<String, int> get frequencyDistribution {
    final Map<String, int> distribution = {
      'Daily': 0,
      'Weekly': 0,
      'Monthly': 0,
    };

    for (var habit in habitController.habits) {
      distribution[habit.frequency] = (distribution[habit.frequency] ?? 0) + 1;
    }

    return distribution;
  }
}