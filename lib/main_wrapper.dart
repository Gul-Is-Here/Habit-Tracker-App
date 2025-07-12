import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:habit_tracker/screens/bottomnav.dart';
import 'package:habit_tracker/screens/calender.dart';
import 'package:habit_tracker/screens/home.dart';
import 'package:habit_tracker/screens/settings.dart';
import 'package:habit_tracker/screens/stats.dart';

class MainWrapper extends StatelessWidget {
  final RxInt currentPageIndex = 0.obs;

  final List<Widget> pages = [
    HomeScreen(),
    CalendarScreen(),
    StatsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[currentPageIndex.value]),
      bottomNavigationBar: Obx(() => CustomBottomNav(
        currentIndex: currentPageIndex.value,
        onTap: (index) => currentPageIndex.value = index,
      )),
    );
  }
}