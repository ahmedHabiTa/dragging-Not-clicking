import 'package:fiction_team_task/components/consants.dart';
import 'package:fiction_team_task/models/cart_attr.dart';
import 'package:fiction_team_task/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartFull extends StatefulWidget {
  final String productId;

  const CartFull({this.productId});

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    Constants constants = Constants();
    final cartModelProvider = Provider.of<CartModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    double subTotal = quantity * cartModelProvider.price;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
        ),
        elevation: 8,
        child: Container(
          height: deviceHeight * 0.2,
          width: deviceWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: const Radius.circular(16.0),
              topRight: const Radius.circular(16.0),
            ),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                width: deviceWidth * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(cartModelProvider.imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              cartModelProvider.quantity == 0 ?Text(
                'Not Available\n right now!',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                ),
              ) :Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left : 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              cartModelProvider.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Entypo.cross,
                                color: Colors.red,
                                size: 22,
                              ),
                              onPressed: () {
                                constants.customDialog(
                                    context,
                                    'Are you Sure ?',
                                    () => cartProvider
                                        .removeItem(widget.productId));
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Price:',style: TextStyle(color: Colors.black87),),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${cartModelProvider.price}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Total:'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${subTotal.toStringAsFixed(2)}\$',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          addMinusBottom(
                            Entypo.minus,
                            () {
                              if (quantity > 1) {
                                cartProvider.decreaseItemQuantityByOne(
                                  widget.productId,
                                  cartModelProvider.title,
                                  cartModelProvider.price,
                                  cartModelProvider.imageUrl,
                                );
                                setState(() {
                                  quantity = quantity - 1;
                                });

                              } else {
                                print('u cant order less than 1');
                                Fluttertoast.showToast(
                                    msg: "u cant order less than 1",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 12,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue[400]),
                              child: Text(
                                '$quantity',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                          ),
                          addMinusBottom(Entypo.plus, () {
                            if (quantity < cartModelProvider.quantity) {
                              cartProvider.addProductToCart(
                                widget.productId,
                                cartModelProvider.title,
                                cartModelProvider.price,
                                cartModelProvider.imageUrl,
                                cartModelProvider.quantity,
                              );
                              setState(() {
                                quantity = quantity + 1;
                              });
                            } else {
                              print('limit reached');
                              Fluttertoast.showToast(
                                  msg: "limit number of products in store reached",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget addMinusBottom(IconData icon, Function function) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: function,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              icon,
              color: Colors.green,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
