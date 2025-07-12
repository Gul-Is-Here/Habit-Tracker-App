import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/habit.dart';

class HabitController extends GetxController {
  var habits = <Habit>[].obs;
  var isLoading = true.obs;
  late SharedPreferences _prefs;
  final Uuid _uuid = const Uuid();

  @override
  void onInit() async {
    super.onInit();
    await initPrefs();
    loadHabits();
  }

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void loadHabits() {
    try {
      final habitStrings = _prefs.getStringList('habits') ?? [];
      habits.assignAll(
          habitStrings.map((str) => Habit.fromJson(jsonDecode(str))).toList());
    } catch (e) {
      habits.assignAll([]);
    } finally {
      isLoading(false);
    }
  }

  Future<void> _saveAllHabits() async {
    final habitStrings =
    habits.map((habit) => jsonEncode(habit.toJson())).toList();
    await _prefs.setStringList('habits', habitStrings);
  }

  Future<void> addHabit({
    required String name,
    required String frequency,
    required String icon,
  }) async {
    final newHabit = Habit(
      id: _uuid.v4(),
      name: name,
      frequency: frequency,
      icon: icon,
      completedDates: [],
      createdAt: DateTime.now(),
    );
    habits.add(newHabit);
    await _saveAllHabits();
  }

  Future<void> updateHabit({
    required String id,
    required String name,
    required String frequency,
    required String icon,
  }) async {
    final index = habits.indexWhere((habit) => habit.id == id);
    if (index != -1) {
      final updatedHabit = Habit(
        id: id,
        name: name,
        frequency: frequency,
        icon: icon,
        completedDates: habits[index].completedDates,
        createdAt: habits[index].createdAt,
      );
      habits[index] = updatedHabit;
      await _saveAllHabits();
    }
  }

  Future<void> deleteHabit(String id) async {
    habits.removeWhere((habit) => habit.id == id);
    await _saveAllHabits();
  }

  Future<void> toggleHabitCompletion(String id, DateTime date) async {
    final index = habits.indexWhere((habit) => habit.id == id);
    if (index != -1) {
      final habit = habits[index];
      final dateKey = formatDateKey(date);

      final updatedDates = List<String>.from(habit.completedDates);
      if (updatedDates.contains(dateKey)) {
        updatedDates.remove(dateKey);
      } else {
        updatedDates.add(dateKey);
      }

      final updatedHabit = Habit(
        id: habit.id,
        name: habit.name,
        frequency: habit.frequency,
        icon: habit.icon,
        completedDates: updatedDates,
        createdAt: habit.createdAt,
      );

      habits[index] = updatedHabit;
      await _saveAllHabits();
    }
  }

  int getCurrentStreak(String id) {
    final habit = habits.firstWhereOrNull((habit) => habit.id == id);
    if (habit == null || habit.completedDates.isEmpty) return 0;

    final dates = habit.completedDates.map((e) => DateTime.parse(e)).toList()
      ..sort((a, b) => b.compareTo(a));

    int streak = 0;
    DateTime currentDate = DateTime.now();
    final todayKey = formatDateKey(currentDate);

    if (habit.completedDates.contains(todayKey)) {
      streak = 1;
      currentDate = currentDate.subtract(const Duration(days: 1));
    }

    while (dates.contains(currentDate)) {
      streak++;
      currentDate = currentDate.subtract(const Duration(days: 1));
    }

    return streak;
  }

  double getHabitCompletionRate(String id) {
    final habit = habits.firstWhereOrNull((habit) => habit.id == id);
    if (habit == null) return 0.0;

    final createdDate = habit.createdAt;
    final daysActive = DateTime.now().difference(createdDate).inDays + 1;
    final completedDays = habit.completedDates.length;

    return completedDays / daysActive;
  }
  String formatDateKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

}