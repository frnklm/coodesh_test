import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_model.dart';
import '../providers/products.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _typeFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _filenameFocusNode = FocusNode();
  final _heightFocusNode = FocusNode();
  final _widthFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _ratingFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final product = ModalRoute.of(context).settings.arguments as Product;

      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['type'] = product.type;
        _formData['description'] = product.description;
        _formData['filename'] = product.filename;
        _formData['height'] = product.height;
        _formData['width'] = product.width;
        _formData['price'] = product.price;
        _formData['rating'] = product.rating;
        _formData['createdAt'] = product.createdAt;
      } else {
        _formData['height'] = '';
        _formData['width'] = '';
        _formData['price'] = '';
        _formData['rating'] = '';
      }
    }
  }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');
    return (startWithHttp || startWithHttps) &&
        (endsWithPng || endsWithJpg || endsWithJpeg);
  }

  @override
  void dispose() {
    super.dispose();
    _typeFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _filenameFocusNode.dispose();
    _heightFocusNode.dispose();
    _widthFocusNode.dispose();
    _priceFocusNode.dispose();
    _ratingFocusNode.dispose();
  }

  Future<void> _saveForm() async {
    var isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();

    final product = Product(
      id: _formData['id'],
      title: _formData['title'],
      type: _formData['type'],
      description: _formData['description'],
      filename: _formData['filename'],
      height: _formData['height'],
      width: _formData['width'],
      price: _formData['price'],
      rating: _formData['rating'],
      createdAt: _formData['createdAt'],
    );

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Products>(context, listen: false);
    if (_formData['id'] == null) {
      //so chama o pop depois de inseirir o produto
      await products.addProduct(product).then((_) {
        Navigator.of(context).pop();
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      await products.updateProduct(product);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formul??rio Produto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _formData['title'],
                      decoration: InputDecoration(labelText: 'T??tulo'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_typeFocusNode);
                      },
                      onSaved: (value) => _formData['title'] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isInvalid = value.trim().length < 3;

                        if (isEmpty || isInvalid) {
                          return 'Informe um T??tulo v??lido com no m??nimo 3 caracteres!';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['type'],
                      decoration: InputDecoration(labelText: 'Tipo'),
                      focusNode: _typeFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) => _formData['type'] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isInvalid = value.trim().length < 3;

                        if (isEmpty || isInvalid) {
                          return 'Informe um Tipo v??lido com no m??nimo 3 caracteres!';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description'],
                      decoration: InputDecoration(labelText: 'Descri????o'),
                      maxLines: 2,
                      focusNode: _descriptionFocusNode,
                      keyboardType: TextInputType.multiline,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_filenameFocusNode);
                      },
                      onSaved: (value) => _formData['description'] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isInvalid = value.trim().length < 10;

                        if (isEmpty || isInvalid) {
                          return 'Informe uma Descri????o v??lida com no m??nimo 10 caracteres!';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['filename'],
                      decoration: InputDecoration(labelText: 'Filename'),
                      focusNode: _filenameFocusNode,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_heightFocusNode);
                      },
                      onSaved: (value) => _formData['filename'] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isInvalid = value.trim().length < 10;

                        if (isEmpty || isInvalid) {
                          return 'Informe uma Filename v??lida com no m??nimo 10 caracteres!';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['height'].toString(),
                      decoration: InputDecoration(labelText: 'Height'),
                      focusNode: _heightFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_widthFocusNode);
                      },
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onSaved: (value) =>
                          _formData['height'] = int.parse(value),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        var newHeight = int.tryParse(value);
                        bool isInvalid = newHeight == null || newHeight <= 0;

                        if (isEmpty || isInvalid) {
                          return 'Informe um Height v??lido!';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['width'].toString(),
                      focusNode: _widthFocusNode,
                      decoration: InputDecoration(labelText: 'Width'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onSaved: (value) => _formData['width'] = int.parse(value),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        var newWidth = int.tryParse(value);
                        bool isInvalid = newWidth == null || newWidth <= 0;

                        if (isEmpty || isInvalid) {
                          return 'Informe um Width v??lido!';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price'].toString(),
                      decoration: InputDecoration(labelText: 'Pre??o'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocusNode,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_ratingFocusNode);
                      },
                      onSaved: (value) =>
                          _formData['price'] = double.parse(value),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        var newPrice = double.tryParse(value);
                        bool isInvalid = newPrice == null || newPrice <= 0;

                        if (isEmpty || isInvalid) {
                          return 'Informe um Pre??o v??lido!';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['rating'].toString(),
                      decoration: InputDecoration(labelText: 'Rating'),
                      textInputAction: TextInputAction.done,
                      focusNode: _ratingFocusNode,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_ratingFocusNode);
                      },
                      onSaved: (value) =>
                          _formData['rating'] = int.parse(value),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        var newPrice = int.tryParse(value);
                        bool isInvalid =
                            newPrice == null || newPrice < 0 || newPrice > 5;

                        if (isEmpty || isInvalid) {
                          return 'Informe um Rating v??lido!';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
