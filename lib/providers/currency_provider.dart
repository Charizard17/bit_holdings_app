import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  String _currency = 'usd';

  String get currency => _currency;

  void setCurrency(String currency) {
    if (_currency != currency) {
      _currency = currency;
    }
    notifyListeners();
  }
}
