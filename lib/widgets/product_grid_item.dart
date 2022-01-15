import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_model.dart';
import '../utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.PRODUCT_DETAIL,
            arguments: product,
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 230.0,
              width: 500.0,
              child: Image.network(
                product.filename,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              width: 500.0,
              height: 100.0,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.black54])),
              ),
            ),
            Positioned(
              top: 180,
              left: 10.0,
              bottom: 10.0,
              right: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                            size: 16.0,
                          ),
                          Text(
                            "(" + product.rating.toString() + " Avaliação)",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "R\$ " + product.price.toString(),
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent),
                      ),
                      Text(
                        product.type.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        product.createdAt.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
