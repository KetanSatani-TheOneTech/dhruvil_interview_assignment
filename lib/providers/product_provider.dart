import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  final List<String> _categories = ['All'];
  String _selectedCategory = 'All';
  bool _isLoading = false;
  bool _isLoadingMore = false;
  int _page = 1;
  final int _limit = 6; // Fetch 5 products per request

  List<Product> get products => _products;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;

  ProductProvider() {
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse('https://fakestoreapi.com/products/categories');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<String> fetchedCategories = List<String>.from(json.decode(response.body));
        _categories.addAll(fetchedCategories);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }
  }

  Future<void> fetchProducts({String category = 'All'}) async {
    _isLoading = true;
    _page = 1; // Reset page for new category
    notifyListeners();

    String url = category == 'All'
        ? 'https://fakestoreapi.com/products'
        : 'https://fakestoreapi.com/products/category/$category';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _products = data.map((json) => Product.fromJson(json)).take(_limit).toList();
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreProducts() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    notifyListeners();

    _page++; // Increment page

    try {
      String url = _selectedCategory == 'All'
          ? 'https://fakestoreapi.com/products'
          : 'https://fakestoreapi.com/products/category/$_selectedCategory';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        final newProducts = data
            .map((json) => Product.fromJson(json))
            .skip((_page - 1) * _limit) // Skip already fetched items
            .take(_limit) // Fetch next set
            .toList();

        if (newProducts.isNotEmpty) {
          _products.addAll(newProducts);
        }
      }
    } catch (e) {
      debugPrint("Error fetching more products: $e");
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  void changeCategory(String category) {
    _selectedCategory = category;
    _products.clear();
    fetchProducts(category: category);
    notifyListeners();
  }
}
