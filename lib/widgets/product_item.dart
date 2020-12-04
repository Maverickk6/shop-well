
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final singleProduct = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: singleProduct.id,
            );
          },
          child: Image.network(
            singleProduct.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (ctx, singleProduct, _) => IconButton(
              icon: Icon(
                singleProduct.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              onPressed: () {
                singleProduct.toggleFavoriteStatus();
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(
                singleProduct.id,
                singleProduct.price,
                singleProduct.title,
              );
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Item Added to Cart!'),
                duration: Duration(seconds: 2,),
                action: SnackBarAction(label: 'UNDO', onPressed: () {
                  cart.removeSingleItem(singleProduct.id);
                }),
              ),);
            },
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Colors.black87,
          title: Text(
            singleProduct.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
