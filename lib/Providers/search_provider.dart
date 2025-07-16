import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  void setSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }
}
