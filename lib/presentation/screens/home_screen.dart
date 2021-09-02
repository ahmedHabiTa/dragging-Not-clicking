import 'package:badges/badges.dart';
import 'package:fiction_team_task/presentation/screens/cart_screen.dart';
import 'package:fiction_team_task/presentation/screens/favourite_screen.dart';
import 'package:fiction_team_task/presentation/screens/upload_product_screen.dart';
import 'package:fiction_team_task/presentation/widgets/feeds_products.dart';
import 'package:fiction_team_task/providers/cart_provider.dart';
import 'package:fiction_team_task/providers/favs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(UploadProductScreen.routeName),
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          title: Text('Feeds'),
          actions: [
            Consumer<FavouriteProvider>(
              builder: (_, favProvider, child) => Badge(
                badgeColor: Colors.blue,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  favProvider.getFavouriteItems.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(FavouriteScreen.routeName),
                ),
              ),
            ),
            Consumer<CartProvider>(
              builder: (_, cartProvider, child) => Badge(
                  badgeColor: Colors.blue,
                  animationType: BadgeAnimationType.slide,
                  toAnimate: true,
                  position: BadgePosition.topEnd(top: 4, end: 7),
                  badgeContent: Text(
                    cartProvider.getCartItems.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.red,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(CartScreen.routeName),
                  )),
            ),
          ],
        ),
        body:FeedProducts(),
      ),
    );
  }
}
