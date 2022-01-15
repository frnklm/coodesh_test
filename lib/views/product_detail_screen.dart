import 'package:flutter/material.dart';
import '../providers/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.filename,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'R\$ ${product.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Text(
                    product.type,
                    textAlign: TextAlign.center,
                  ),
                  Divider(),
                  Text(
                    product.description,
                    textAlign: TextAlign.center,
                  ),
                  Divider(),
                  Text(
                    'Height: ${product.height}',
                    textAlign: TextAlign.center,
                  ),
                  Divider(),
                  Text(
                    'Width: ${product.width}',
                    textAlign: TextAlign.center,
                  ),
                  Divider(),
                  Text(
                    'CreatedAt: ${product.createdAt}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
