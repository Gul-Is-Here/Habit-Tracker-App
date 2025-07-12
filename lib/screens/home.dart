import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/habit_controller.dart';
import '../controllers/quotes_controller.dart';
import '../widgets/habit_tile.dart';
import '../widgets/quote.dart';
import 'addhabit.dart';
import 'habit_detail.dart';

class HomeScreen extends StatelessWidget {
  final HabitController habitController = Get.find();
  final QuoteController quoteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Habits', style: GoogleFonts.poppins()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.to(() => AddHabitScreen()),
          ),
        ],
      ),
      body: Obx(() {
        if (habitController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            habitController.loadHabits();
            quoteController.getRandomQuote();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Motivational Quote
                QuoteCard(
                  quote: quoteController.currentQuote['text'] ?? '',
                  author: quoteController.currentQuote['author'] ?? '',
                ),
                const SizedBox(height: 20),

                // Habits List
                ...habitController.habits.map((habit) {
                  final streak = habitController.getCurrentStreak(habit.id);
                  return HabitTile(
                    habit: habit,
                    streak: streak,
                    onTap: () => Get.to(
                          () => HabitDetailScreen(habitId: habit.id),
                    ),
                    onCheck: (isChecked) {
                      habitController.toggleHabitCompletion(
                        habit.id,
                        DateTime.now(),
                      );
                    },
                  );
                }).toList(),

                if (habitController.habits.isEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'No habits yet!',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Get.theme.hintColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Tap the + button to add your first habit',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Get.theme.hintColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}