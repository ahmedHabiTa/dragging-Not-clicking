import 'package:fiction_team_task/models/product.dart';
import 'package:fiction_team_task/presentation/screens/home_screen.dart';
import 'package:fiction_team_task/presentation/screens/my_info_screen.dart';
import 'package:fiction_team_task/providers/cart_provider.dart';
import 'package:fiction_team_task/providers/favs_provider.dart';
import 'package:fiction_team_task/providers/products_provider.dart';
import 'package:fiction_team_task/providers/upload_product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CartProvider>(
        create: (c) => CartProvider(),
      ),
      ChangeNotifierProvider<FavouriteProvider>(
        create: (c) => FavouriteProvider(),
      ),
      ChangeNotifierProvider<ProductsProvider>(
        create: (c) => ProductsProvider()..fetchProducts(),
      ),
      ChangeNotifierProvider<UploadProductProvider>(
        create: (c) => UploadProductProvider(),
      ),
      ChangeNotifierProvider<Product>(
        create: (c) => Product(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FictionAppTeams',
      debugShowCheckedModeBanner: false,
      home: MyInfoScreen(),
      routes: routes,
    );
  }
}
