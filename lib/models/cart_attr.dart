import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String id;

  final String title;
  final String productId;

  final int quantity;

  final double price;

  final String imageUrl;

  CartModel(
      {this.id,
        @required this.productId,
        this.title,
        this.quantity,
        this.price,
        this.imageUrl});
}
