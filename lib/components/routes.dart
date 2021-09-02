import 'package:fiction_team_task/presentation/screens/cart_screen.dart';
import 'package:fiction_team_task/presentation/screens/favourite_screen.dart';
import 'package:fiction_team_task/presentation/screens/home_screen.dart';
import 'package:fiction_team_task/presentation/screens/upload_product_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  UploadProductScreen.routeName: (context) => UploadProductScreen(),
  FavouriteScreen.routeName: (context) => FavouriteScreen(),
  CartScreen.routeName: (context) => CartScreen(),

};