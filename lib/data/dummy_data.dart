import '../providers/product_model.dart';

final DUMMY_PRODUCTS = [
  Product(
    id: 'p1',
    title: 'Red Shirt',
    type: 'dairy',
    description: 'A red shirt - it is pretty red! ',
    filename:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    height: 600,
    width: 400,
    price: 29.99,
    rating: 4,
    createdAt: DateTime.now(),
  ),
  Product(
    id: 'p2',
    title: 'Trousers',
    type: 'dairy',
    description: 'A nice pair of trousers.',
    filename:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    height: 600,
    width: 400,
    price: 59.99,
    rating: 4,
    createdAt: DateTime.now(),
  ),
  Product(
    id: 'p3',
    title: 'Yellow Scarf',
    type: 'dairy',
    description: 'Warm and cozy - exactly what you need for the winter.',
    filename: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    height: 600,
    width: 400,
    price: 19.99,
    rating: 4,
    createdAt: DateTime.now(),
  ),
];
