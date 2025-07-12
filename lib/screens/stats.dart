import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/stats_controller.dart';

class StatsScreen extends StatelessWidget {
  final StatsController statsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics', style: GoogleFonts.poppins())),
      body: Obx(() {
        // Safe calculations with fallbacks
        final totalHabits = statsController.totalHabits;
        final safeCompletionRate =
            totalHabits == 0
                ? 0.0
                : (statsController.overallCompletionRate.isNaN
                    ? 0.0
                    : statsController.overallCompletionRate.clamp(0.0, 1.0));

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildStatCard(
                title: 'Total Habits',
                value: totalHabits.toString(),
                icon: Icons.list_alt,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                title: 'Completed Today',
                value: statsController.completedToday.toString(),
                icon: Icons.check_circle_outline,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                title: 'Longest Streak',
                value: '${statsController.longestStreak} days',
                icon: Icons.local_fire_department,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                title: 'Overall Completion',
                value: '${(safeCompletionRate * 100).toStringAsFixed(1)}%',
                icon: Icons.trending_up,
              ),
              const SizedBox(height: 30),
              Text(
                'Habit Distribution',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildFrequencyDistribution(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Get.theme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: Get.theme.primaryColor),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Get.theme.hintColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencyDistribution() {
    return Obx(() {
      final distribution = statsController.frequencyDistribution;
      final total = statsController.totalHabits;

      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...distribution.entries.map((entry) {
                final safeValue = total == 0 ? 0.0 : entry.value / total;
                final percentage = (safeValue * 100).toStringAsFixed(1);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(entry.key, style: GoogleFonts.poppins()),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value:
                              safeValue.isNaN ? 0.0 : safeValue.clamp(0.0, 1.0),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                          backgroundColor: Get.theme.dividerColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Get.theme.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text('$percentage%', style: GoogleFonts.poppins()),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      );
    });
  }
}
