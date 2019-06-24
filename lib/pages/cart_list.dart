import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model/Item.dart';
import '../scoped-model/items_model.dart';
import 'cart_card.dart';

class Cart extends StatelessWidget {
  Widget _buildProductItems(
      BuildContext context, int position, Item item, ProductsModel model) {
    return CartCard(item);
  }

  Widget _buildProductList(List<Item> items, ProductsModel model) {
    Widget productCard;
    if (items.length > 0) {
      productCard = SafeArea(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => _buildProductItems(
                context,
                index,
                items[index],
                model,
              ),
          itemCount: items.length,
        ),
      );
    } else {
      productCard = Center(child: Text('YOUR CART IS EMPTY  :( '));
    }
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return _buildProductList(model.getCartList, model);
      },
    );
  }
}
