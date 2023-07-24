import 'package:flutter/material.dart';
import 'package:tienda/product_model.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('\$${product.price.toStringAsFixed(2)}'),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _products.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration:
                        InputDecoration(labelText: 'Nombre del producto'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un nombre';
                      }

                      // Expresión regular para aceptar solo letras y espacios
                      final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

                      if (!nameRegExp.hasMatch(value)) {
                        return 'Ingresa solo letras y espacios';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Descripción'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa una descripción';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _priceController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: 'Precio'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un precio';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, ingresa un precio válido';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          final name = _nameController.text;
                          final description = _descriptionController.text;
                          final price = double.parse(_priceController.text);
                          _products.add(Product(
                              name: name,
                              description: description,
                              price: price));
                          _nameController.clear();
                          _descriptionController.clear();
                          _priceController.clear();
                        });
                      }
                    },
                    child: Text('Agregar Producto'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
