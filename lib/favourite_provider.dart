import 'package:flutter/material.dart';

class FavouriteProvider with ChangeNotifier {
  final List<Map<String, String>> _favourites = [];

  List<Map<String, String>> get favourites => _favourites;

  void addFavourite(Map<String, String> news) {
    if (!_favourites.contains(news)) {
      _favourites.add(news);
      notifyListeners();
    }
  }

  void removeFavourite(Map<String, String> news) {
    if (_favourites.contains(news)) {
      _favourites.remove(news);
      notifyListeners();
    }
  }

  bool isFavourite(Map<String, String> news) {
    return _favourites.contains(news);
  }
}
