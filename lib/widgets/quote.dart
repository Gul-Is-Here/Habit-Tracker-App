import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Get.theme.primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '"$quote"',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '- $author',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Get.theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}