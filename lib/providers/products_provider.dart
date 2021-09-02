import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiction_team_task/models/product.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return _products;
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        _products.insert(
          0,
          Product(
            id: element.get('productID'),
            title: element.get('title'),
            description: element.get('description'),
            price: element.get('price'),
            imageUrl: element.get('imageUrl'),
            oldPrice: element.get('oldPrice'),
            quantity: element.get('quantity'),
            sale: element.get('sale'),
            newProduct: element.get('newProduct'),
          ),
        );
      });
    });
  }
}
