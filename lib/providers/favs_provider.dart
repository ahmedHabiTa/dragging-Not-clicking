
import 'package:fiction_team_task/models/favs_attr.dart';
import 'package:flutter/material.dart';

class FavouriteProvider with ChangeNotifier {
  Map<String, FavouriteModel> _favouriteItems = {};

  Map<String, FavouriteModel> get getFavouriteItems {
    return _favouriteItems;
  }


  void addProductToFavourite(
      String productId, String title, double price, String imageUrl,String description) {
    if (_favouriteItems.containsKey(productId)) {
      removeItem(productId);
    } else {
      _favouriteItems.putIfAbsent(
          productId,
              () => FavouriteModel(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            imageUrl: imageUrl,
                description: description
          ));
    }
    notifyListeners();
  }


  void removeItem(String productId) async {
    _favouriteItems.remove(productId);
    notifyListeners();
  }

  void clearFavourites() {
    _favouriteItems.clear();
    notifyListeners();
  }
}
