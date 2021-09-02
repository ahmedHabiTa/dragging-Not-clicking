import 'package:fiction_team_task/components/consants.dart';
import 'package:fiction_team_task/components/custom_icons.dart';
import 'package:fiction_team_task/providers/cart_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/cart_full.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    Constants constants = Constants();
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                  'Products in Cart (${cartProvider.getCartItems.length})'),
            ),
            body: Center(
              child: Text(
                'No Products in Cart !',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                  'Products in Cart (${cartProvider.getCartItems.length})'),
              actions: [
                IconButton(
                  onPressed: () => constants.customDialog(context,
                      'Cart will be cleared', () => cartProvider.clearCart()),
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: ListView.builder(
                itemCount: cartProvider.getCartItems.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ChangeNotifierProvider.value(
                    child: CartFull(
                      productId: cartProvider.getCartItems.keys.toList()[index],
                    ),
                    value: cartProvider.getCartItems.values.toList()[index],
                  );
                }));
  }
}
