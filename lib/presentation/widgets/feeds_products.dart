import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiction_team_task/components/custom_icons.dart';
import 'package:fiction_team_task/models/product.dart';
import 'package:fiction_team_task/providers/cart_provider.dart';
import 'package:fiction_team_task/providers/favs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'custom_product_grid_item.dart';

class FeedProducts extends StatefulWidget {
  @override
  _FeedProductsState createState() => _FeedProductsState();
}

class _FeedProductsState extends State<FeedProducts> {
  bool onDragAction = false;
  bool onDragToCartChange = false;
  bool onDragToFavouriteChange = false;


  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context);
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    return Stack(
      children: [
        Container(),
        if (onDragAction == true)
          Positioned(

            child: DragTarget<Product>(
              key: _formKey,
              builder: (context, productsList, _) {
                return Consumer<CartProvider>(
                  builder: (_, cartProvider, child) => Container(
                    height: deviceHeight * 0.1,
                    width: deviceWidth,
                    color:
                    onDragToCartChange == false ? Colors.white : Colors.grey,
                    child: Icon(
                      onDragToCartChange == false
                          ? Icons.shopping_cart_outlined
                          : Icons.shopping_cart,
                      color:  Colors.blue[900],
                      size: deviceHeight * 0.08,
                    ),
                  ),
                );
              },
              onAccept: (product) {
                if(product.quantity == 0){
                  Fluttertoast.showToast(
                      msg: "Cannot Add at the moment",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }else{
                  cartProvider.addProductToCart(
                    product.id,
                    product.title,
                    product.price,
                    product.imageUrl,
                    product.quantity,
                  );
                  setState(() {
                    onDragAction = false;
                    onDragToCartChange = false;
                  });
                }
              },
              onWillAccept: (_) {
                setState(() {
                  onDragToCartChange = true;
                });
                return onDragToCartChange;
              },
              onLeave: (_) {
                setState(() {
                  onDragToCartChange = false;
                  onDragAction = false;
                });
              },
            ),
          ),
        if (onDragAction == true)
          Positioned(
            top: deviceHeight * 0.3,
            bottom: deviceHeight * 0.3,
            right: 0,
            child: DragTarget<Product>(
              builder: (context, productsList, _) {
                return Consumer<FavouriteProvider>(
                  builder: (_, favProvider, child) => Container(
                    width: deviceWidth * 0.1,
                    height: deviceHeight * 0.4,
                    color:
                    onDragToFavouriteChange == false ? Colors.white : Colors.grey,
                    child: Icon(
                      onDragToFavouriteChange == false
                          ? Icons.favorite_outline_rounded
                          : Icons.favorite,
                      color: onDragToFavouriteChange == false
                          ? Colors.grey[800]
                          : Colors.red,
                      size: deviceWidth * 0.1,
                    ),
                  ),
                );
              },
              onWillAccept: (_) {
                setState(() {
                  onDragToFavouriteChange = true;
                });
                return onDragToFavouriteChange;
              },
              onLeave: (_) {
                setState(() {
                  onDragToFavouriteChange = false;
                });
              },
              onAccept: (product) {
                if(product.quantity == 0){
                  Fluttertoast.showToast(
                      msg: "Cannot Add at the moment",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }else{
                  favouriteProvider.addProductToFavourite(
                    product.id,
                    product.title,
                    product.price,
                    product.imageUrl,
                    product.description,
                  );
                  setState(() {
                    onDragAction = false;
                    onDragToFavouriteChange = false;
                  });
                }
              },
            ),
          ),
        Positioned(
          right: onDragAction == true ? deviceWidth * 0.1 : 0,
          top: onDragAction == true ? deviceHeight * 0.1 : 0,
          child: Container(
            width: onDragAction == true ? deviceWidth * 0.9 : deviceWidth,
            height: deviceHeight,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .snapshots(),
                builder: (context, dataSnapshot) {
                  return !dataSnapshot.hasData
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: deviceWidth * 0.5,
                            childAspectRatio:
                                deviceHeight * 0.46 / deviceWidth * 0.5,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (ctx, index) {
                            Product model = Product.fromJson(
                                dataSnapshot.data.docs[index].data());
                            return Draggable<Product>(
                              rootOverlay: false,
                              onDragStarted: () {
                                setState(() {
                                  onDragAction = true;
                                });
                              },
                              onDragEnd: (_) {
                                setState(() {
                                  onDragAction = false;
                                });
                              },
                              data: model,
                              feedback: Container(
                                height: deviceHeight * 0.2,
                                width: deviceWidth * 0.4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(model.imageUrl),
                                )),
                              ),
                              child: CustomProductGridItem(
                                imageUrl: model.imageUrl,
                                newProduct: model.newProduct,
                                oldPrice: model.oldPrice.toString(),
                                sale: model.sale,
                                price: model.price.toString(),
                                description: model.description,
                                quantity: model.quantity.toString(),
                                customIconBottom1: customIconButton(
                                  cartProvider.getCartItems
                                          .containsKey(model.id)
                                      ? MaterialCommunityIcons.cart
                                      : MaterialCommunityIcons.cart_plus,
                                  () {
                                    cartProvider.addProductToCart(
                                      model.id,
                                      model.title,
                                      model.price,
                                      model.imageUrl,
                                      model.quantity,
                                    );
                                  },
                                  Colors.blue[900],
                                ),
                                customIconBottom2: customIconButton(
                                  favouriteProvider.getFavouriteItems
                                          .containsKey(model.id)
                                      ? Icons.favorite
                                      : MyAppIcons.wishlist,
                                  () {
                                    favouriteProvider.addProductToFavourite(
                                        model.id,
                                        model.title,
                                        model.price,
                                        model.imageUrl,
                                    model.description);
                                  },
                                  favouriteProvider.getFavouriteItems
                                          .containsKey(model.id)
                                      ? Colors.red
                                      : Colors.blue[900],
                                ),
                              ),
                            );
                          },
                          itemCount: dataSnapshot.data.docs.length,
                        );
                }),
          ),
        ),
      ],
    );
  }
  Widget customIconButton(IconData icon, Function function, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: color,
      ),
      onPressed: function,
    );
  }
}
