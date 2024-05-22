import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Shop extends ChangeNotifier {
  List<Product> _shop = [];
  List<Product> _cart = [];

  List<Product> get shop => _shop;
  List<Product> get cart => _cart;

  Future<void> fetchProducts() async { 
    try {
      // Replace "YOUR_API_ENDPOINT" with the actual endpoint of your API
      final response = await http.get(Uri.parse('https://ecommercebackend-x2kr.onrender.com/user/result'));

      if (response.statusCode == 200) {
        final List<dynamic> decodedJson = jsonDecode(response.body);
        _shop = decodedJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }

    notifyListeners();
  }

  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }
}