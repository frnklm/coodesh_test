import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shop/providers/products.dart';

class ProductMock extends Mock implements Products {}

void main() {
  final products = Products();

  test('carregar produto', () async {
    final productsTest = await products;

    expect(productsTest.loadProducts(), isNotNull);
    print(productsTest.loadProducts().toString());
  });

  test('deletar produto', () async {
    final productsTest = await products;
    String id = '5';

    expect(productsTest.deleteProduct(id), isNotNull);
    print(productsTest.deleteProduct(id).toString());
  });
}
