import 'package:get/get.dart';

class QuoteController extends GetxController {
  final quotes = [
    {
      "text": "We are what we repeatedly do. Excellence, then, is not an act, but a habit.",
      "author": "Aristotle"
    },
    {
      "text": "Small daily improvements are the key to staggering long-term results.",
      "author": "Robin Sharma"
    },
    {
      "text": "First forget inspiration. Habit is more dependable.",
      "author": "Octavia Butler"
    },
    {
      "text": "The secret of getting ahead is getting started.",
      "author": "Mark Twain"
    },
    {
      "text": "Good habits are worth being fanatical about.",
      "author": "Ian Botham"
    },
  ].obs;

  var currentQuote = {}.obs;

  @override
  void onInit() {
    super.onInit();
    getRandomQuote();
  }

  void getRandomQuote() {
    final randomIndex = (quotes.length * (DateTime.now().millisecond / 1000)).floor();
    currentQuote(quotes[randomIndex % quotes.length]);
  }
}