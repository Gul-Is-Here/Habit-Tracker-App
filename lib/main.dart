import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/routes.dart';
import 'package:habit_tracker/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/habit_controller.dart';
import 'controllers/quotes_controller.dart';
import 'controllers/stats_controller.dart';
import 'controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => SharedPreferences.getInstance());
  Get.put(ThemeController());
  Get.put(HabitController());
  Get.put(QuoteController());
  Get.put(StatsController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() => GetMaterialApp(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      initialRoute: Routes.splash,  // Splash appears first
      getPages: AppPages.pages,
      defaultTransition: Transition.fade,
      // home: HomeScreen(),
    ));
  }
}