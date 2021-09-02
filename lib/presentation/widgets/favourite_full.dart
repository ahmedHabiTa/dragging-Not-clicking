import 'package:fiction_team_task/components/consants.dart';
import 'package:fiction_team_task/models/favs_attr.dart';
import 'package:fiction_team_task/providers/favs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteFull extends StatefulWidget {
  final String productId;

  const FavouriteFull({this.productId});

  @override
  _FavouriteFullState createState() => _FavouriteFullState();
}

class _FavouriteFullState extends State<FavouriteFull> {
  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    final favouriteModel = Provider.of<FavouriteModel>(context);
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.white),
              child: Column(
                children: [
                  Container(
                    height: deviceHeight * 0.27,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(favouriteModel.imageUrl),
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 5, left: 5),
                          child: Text(
                            '${favouriteModel.title}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Divider(
                          thickness: 3,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 5, left: 5),
                          child: Text(
                            '${favouriteModel.description}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 5, left: 5),
                          child: Text(
                            'price: ${favouriteModel.price}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
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
        ),
        positionedRemove(widget.productId, context),
      ],
    );
  }

  Widget positionedRemove(String productId, context) {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    Constants constants = Constants();
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.all(0.0),
          color: Colors.red,
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            constants.customDialog(context, 'Remove from favourites ?',
                () => favouriteProvider.removeItem(productId));
          },
        ),
      ),
    );
  }
}
