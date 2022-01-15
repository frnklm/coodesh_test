import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_model.dart';

import '../widgets/product_grid_item.dart';
import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid();

  @override
  Widget build(BuildContext context) {
    final List<Product> loadedProducts = Provider.of<Products>(context).items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductGridItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
