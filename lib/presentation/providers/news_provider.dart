import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_service.dart';
import '../../data/model/article.dart';

class NewsProvider with ChangeNotifier {
  List<Article> _articles = [];
  List<Article> _favoriteArticles = [];
  List<Article> _searchedArticles = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<Article> get articles => _searchedArticles.isNotEmpty ? _searchedArticles : _articles;
  List<Article> get favoriteArticles => _favoriteArticles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  // Gọi hàm này khi khởi động app
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString('favorites_data');
    if (favoritesJson != null) {
      List decoded = json.decode(favoritesJson);
      _favoriteArticles = decoded.map((item) => Article.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      _favoriteArticles.map((item) => item.toJson()).toList(),
    );
    prefs.setString('favorites_data', encodedData);
  }

  Future<void> loadNews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await _apiService.fetchNews();
    } catch (e) {
      _errorMessage = 'Không có kết nối mạng hoặc API lỗi.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchNews(String query) {
    if (query.isEmpty) {
      _searchedArticles = [];
    } else {
      _searchedArticles = _articles
          .where((article) => article.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void toggleFavorite(Article article) {
    if (_favoriteArticles.contains(article)) {
      _favoriteArticles.remove(article);
    } else {
      _favoriteArticles.add(article);
    }
    _saveFavorites(); // Lưu lại mỗi khi có thay đổi
    notifyListeners();
  }

  bool isFavorite(Article article) {
    return _favoriteArticles.contains(article);
  }
}