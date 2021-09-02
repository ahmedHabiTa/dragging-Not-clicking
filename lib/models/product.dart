import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
   String id;
   String title;
   String description;
   double price;
   double oldPrice;
   String imageUrl;
   int quantity;
   bool sale;
   bool newProduct;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.oldPrice,
    this.sale,
    this.newProduct,
    this.quantity,

  });
  Product.fromJson(Map<String, dynamic> json) {
    id = json['productID'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    imageUrl = json['imageUrl'];
    oldPrice = json['oldPrice'];
    sale = json['sale'];
    quantity = json['quantity'];
    newProduct = json['newProduct'];
  }
}
