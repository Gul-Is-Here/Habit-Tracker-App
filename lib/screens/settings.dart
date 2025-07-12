import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.poppins()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Obx(() => SwitchListTile(
            title: Text('Dark Mode', style: GoogleFonts.poppins()),
            value: themeController.isDarkMode.value,
            onChanged: (value) => themeController.toggleTheme(),
          )),
          const Divider(),
          ListTile(
            title: Text('About', style: GoogleFonts.poppins()),
            subtitle: Text('Habit Tracker v1.0.0'),
            onTap: () => Get.dialog(
              AlertDialog(
                title: Text('About', style: GoogleFonts.poppins()),
                content: Text(
                  'Habit Tracker helps you build good habits and break bad ones. Track your progress and stay motivated!',
                  style: GoogleFonts.poppins(),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}