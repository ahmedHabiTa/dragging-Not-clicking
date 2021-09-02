import 'package:fiction_team_task/components/consants.dart';
import 'package:fiction_team_task/components/custom_icons.dart';
import 'package:fiction_team_task/presentation/widgets/favourite_full.dart';
import 'package:fiction_team_task/providers/favs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    final favouriteList = favouriteProvider.getFavouriteItems;
    Constants constants = Constants();
    return favouriteList.isEmpty
        ? Scaffold(
      appBar: AppBar(
        title: Text(
            'Products in Cart (${favouriteProvider.getFavouriteItems.length})'),
      ),
      body: Center(
        child: Text(
          'No Products in Favourite List!',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 30,
          ),
        ),
      ),
    )
        : Scaffold(
            appBar: AppBar(
              title: Text('Favourites (${favouriteList.length})'),
              actions: [
                IconButton(
                  onPressed: () => constants.customDialog(
                      context,
                      'All Favourites will be cleared',
                      () => favouriteProvider.clearFavourites()),
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: deviceWidth * 0.5,
                childAspectRatio: deviceHeight * 0.46 / deviceWidth * 0.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                  child: FavouriteFull(
                    productId: favouriteList.keys.toList()[index],
                  ),
                  value: favouriteList.values.toList()[index],
                );
              },
              itemCount: favouriteList.length,
            ),
          );
  }
}
