import 'dart:convert';
import 'package:flutter/material.dart';
import 'product_model.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String _baseUrl =
      'https://coodesh-test-default-rtdb.firebaseio.com/coodesh';
  List<Product> _items = [];

  List<Product> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse("$_baseUrl.json"));

    Map<String, dynamic> data = jsonDecode(response.body);
    _items.clear();

    data.forEach((productId, productData) {
      _items.add(Product(
        //pega a chave do firebase
        id: productId,
        title: productData['title'],
        type: productData['type'],
        description: productData['description'],
        filename: productData['filename'],
        height: productData['height'],
        width: productData['width'],
        price: productData['price'],
        rating: productData['rating'],
        createdAt: DateTime.now(),
      ));
      notifyListeners();
      return Future.value();
    });
  }

  Future<void> addProduct(Product newProduct) async {
    final response = await http.post(
      Uri.parse("$_baseUrl.json"),
      body: jsonEncode({
        'title': newProduct.title,
        'type': newProduct.type,
        'description': newProduct.description,
        'filename': newProduct.filename,
        'height': newProduct.height,
        'width': newProduct.width,
        'price': newProduct.price,
        'rating': newProduct.rating,
      }),
    );
    _items.add(Product(
      //pega a chave do firebase
      id: jsonDecode(response.body)['name'],
      title: newProduct.title,
      type: newProduct.type,
      description: newProduct.description,
      filename: newProduct.filename,
      height: newProduct.height,
      width: newProduct.width,
      price: newProduct.price,
      rating: newProduct.rating,
      createdAt: DateTime.now(),
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      await http.patch(Uri.parse("$_baseUrl/${product.id}.json"),
          body: jsonEncode(
            {
              'title': product.title,
              'type': product.type,
              'description': product.description,
              'filename': product.filename,
              'height': product.height,
              'width': product.width,
              'price': product.price,
              'rating': product.rating,
            },
          ));
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final product = _items[index];

      await http.delete(Uri.parse("$_baseUrl/${product.id}.json"));

      print(http.delete(Uri.parse("$_baseUrl/${product.id}.json")).toString());

      _items.remove(product);
      notifyListeners();
    }
  }
}
