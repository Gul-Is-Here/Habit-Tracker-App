import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitProgress extends StatelessWidget {
  final double completionRate;

  const HabitProgress({super.key, required this.completionRate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Completion Progress',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: CircularProgressIndicator(
                value: completionRate,
                strokeWidth: 12,
                backgroundColor: Get.theme.dividerColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Get.theme.primaryColor,
                ),
              ),
            ),
            Text(
              '${(completionRate * 100).toStringAsFixed(1)}%',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}