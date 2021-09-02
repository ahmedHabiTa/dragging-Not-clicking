import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class CustomProductGridItem extends StatelessWidget {
  final String imageUrl;

  final String description;

  final String price;
  final String oldPrice;

  final Widget customIconBottom1;
  final Widget customIconBottom2;
  final String quantity;
  final bool newProduct;
  final bool sale;

  const CustomProductGridItem({
    @required this.imageUrl,
    @required this.description,
    @required this.price,
    @required this.oldPrice,
    @required this.customIconBottom1,
    @required this.customIconBottom2,
    @required this.quantity,
    @required this.newProduct,
    @required this.sale,
  });

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: Colors.white),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: deviceHeight * 0.27,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(imageUrl),
                    )),
                  ),
                  if (newProduct == true)
                    Positioned(
                      child: Badge(
                        alignment: Alignment.center,
                        toAnimate: true,
                        shape: BadgeShape.square,
                        badgeColor: Colors.pink,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(8)),
                        badgeContent:
                            Text('New', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                ],
              ),
              int.parse(quantity) ==0 ?
              Text(
                'Not Available\n right now!',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                ),
              ): Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 5, left: 5),
                      child: Row(
                        children: [
                          Text(
                            'price: $price',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                sale == true ? Colors.green : Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                          Spacer(),
                          if (sale == true)
                            Text(
                              oldPrice,
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationStyle: TextDecorationStyle.double,
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w900),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        customIconBottom1,
                        SizedBox(
                          width: 30,
                        ),
                        customIconBottom2
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'products left : $quantity',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
