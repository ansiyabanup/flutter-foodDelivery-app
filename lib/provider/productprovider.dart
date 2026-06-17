import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      'https://fake-store-api.mock.beeceptor.com/api/products',
    );

    try {
      final response = await http.get(url);
      final List data = json.decode(response.body);

      _products = data.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }
}
