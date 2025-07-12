import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:habit_tracker/screens/addhabit.dart';
import 'package:habit_tracker/screens/habit_detail.dart';
import 'package:habit_tracker/screens/splash.dart';

import 'main_wrapper.dart';

class Routes {
  static const splash = '/';
  static const mainWrapper = '/main-wrapper';
  static const addHabit = '/add-habit';
  static const habitDetail = '/habit-detail';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.splash, page: () => SplashScreen()),
    GetPage(name: Routes.mainWrapper, page: () => MainWrapper()),
    GetPage(name: Routes.addHabit, page: () => AddHabitScreen()),
    GetPage(name: Routes.habitDetail, page: () {
      final habitId = Get.parameters['id']!;
      return HabitDetailScreen(habitId: habitId);
    }),
  ];
}