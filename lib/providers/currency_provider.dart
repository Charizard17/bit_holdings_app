import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  String currency = 'USD';

  void setCurrency(String value) {
    if (currency != value) {
      currency = value;
    }
    notifyListeners();
  }
}
