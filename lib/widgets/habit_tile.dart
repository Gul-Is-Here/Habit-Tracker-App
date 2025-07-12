import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/widgets/streak.dart';

class HabitTile extends StatelessWidget {
  final dynamic habit;
  final int streak;
  final VoidCallback onTap;
  final Function(bool?) onCheck;

  const HabitTile({
    super.key,
    required this.habit,
    required this.streak,
    required this.onTap,
    required this.onCheck,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emoji icon
              Text(
                habit.icon,
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(width: 12),

              // Text and streak section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Habit name
                    Text(
                      habit.name.toString().replaceAll('\n', ' '),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Frequency text
                    Text(
                      habit.frequency,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Get.theme.hintColor,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Streak counter moved down
                    Container(
                      alignment: Alignment.bottomRight,
                        child: StreakCounter(streakCount: streak)),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Checkbox at the right
              Align(
                alignment: Alignment.topCenter,
                child: Checkbox(
                  value: habit.completedDates
                      .contains(_formatDateKey(DateTime.now())),
                  onChanged: onCheck,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Card(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     child: InkWell(
  //       onTap: onTap,
  //       child: Padding(
  //         padding: const EdgeInsets.all(12),
  //         child: Row(
  //           children: [
  //             Text(
  //               habit.icon,
  //               style: const TextStyle(fontSize: 28),
  //             ),
  //             const SizedBox(width: 12),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     habit.name.toString().replaceAll('\n', ' '), // Make sure it's single-line
  //                     maxLines: 2,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: GoogleFonts.poppins(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 4),
  //                   Text(
  //                     habit.frequency,
  //                     style: GoogleFonts.poppins(
  //                       fontSize: 12,
  //                       color: Get.theme.hintColor,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             StreakCounter(streakCount: streak),
  //             const SizedBox(width: 12),
  //             Checkbox(
  //               value: habit.completedDates
  //                   .contains(_formatDateKey(DateTime.now())),
  //               onChanged: onCheck,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  String _formatDateKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}