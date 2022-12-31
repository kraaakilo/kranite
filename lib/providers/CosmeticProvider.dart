import 'package:flutter/material.dart';
import '../models/Cosmetic.dart';

class CosmeticProvider extends ChangeNotifier {
  List<Cosmetic> _cosmetics = [];
  List<Cosmetic> _untouched = [];

  List<Cosmetic> get getCosmetics => _cosmetics;

  void setCosmetics(List<Cosmetic> data) {
    _cosmetics = _untouched = data;
    notifyListeners();
  }

  void searchCosmetics(String value) {
    _cosmetics = _untouched
        .where((element) =>
        element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    notifyListeners();
  }
  void filterCosmetics(String value) {
    _cosmetics = _untouched
        .where((Cosmetic element) =>
        element.type.toLowerCase() == value.toLowerCase())
        .toList();

    notifyListeners();
  }
}
