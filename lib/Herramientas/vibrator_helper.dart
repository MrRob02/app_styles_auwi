import 'package:flutter/services.dart';

class VibratorHelper {
  static Future vibrate([int quantity = 1]) async {
    for (var i = 0; i < quantity; i++) {
      await HapticFeedback.vibrate();
      await HapticFeedback.vibrate();
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }
}
