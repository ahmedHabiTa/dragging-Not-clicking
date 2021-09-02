import 'package:fiction_team_task/models/cart_attr.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  double get getTotalAmount {
    var totalAmount = 0.0;
    _cartItems.forEach((key, value) {
      totalAmount = value.price * value.quantity;
    });
    return totalAmount;
  }

  void addProductToCart(
      String productId, String title, double price, String imageUrl,int quantity) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
              (existingInCart) => CartModel(
            productId: existingInCart.productId,
            id: existingInCart.id,
            title: existingInCart.title,
            price: existingInCart.price,
            quantity: existingInCart.quantity ,
            imageUrl: existingInCart.imageUrl,
          ));
    } else {
      _cartItems.putIfAbsent(
          productId,
              () => CartModel(
            productId: productId,
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: quantity,
            imageUrl: imageUrl,
          ));
    }
    notifyListeners();
  }

  void decreaseItemQuantityByOne(
      String productId, String title, double price, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
              (existingInCart) => CartModel(
            productId: existingInCart.productId,
            id: existingInCart.id,
            title: existingInCart.title,
            price: existingInCart.price,
            quantity: existingInCart.quantity ,
            imageUrl: existingInCart.imageUrl,
          ));
    }
    notifyListeners();
  }

  void removeItem(String productId) async {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
