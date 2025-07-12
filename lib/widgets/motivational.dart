import 'dart:math';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class QuoteController extends GetxController {
  final quotes = [
    "The secret of getting ahead is getting started.",
    "Small daily improvements are the key to staggering long-term results.",
    "We are what we repeatedly do. Excellence, then, is not an act, but a habit.",
    "First forget inspiration. Habit is more dependable.",
    "Good habits are worth being fanatical about.",
  ].obs;

  RxString currentQuote = "".obs;

  @override
  void onInit() {
    super.onInit();
    getRandomQuote();
  }

  void getRandomQuote() {
    final random = Random();
    currentQuote.value = quotes[random.nextInt(quotes.length)];
  }
}