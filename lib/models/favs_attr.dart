import 'package:flutter/material.dart';

class FavouriteModel with ChangeNotifier {
  final String id;

  final String title;

  final double price;

  final String imageUrl;
  final String description;

  FavouriteModel({
    this.id,
    this.title,
    this.price,
    this.imageUrl,
    this.description,
  });
}
