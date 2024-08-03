import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    );
  }
}

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, TextEditingController>> _productControllers = [];
  double _subtotal = 0.0;

  void _addProductFields() {
    setState(() {
      _productControllers.add({
        'product': TextEditingController(),
        'price': TextEditingController(),
      });
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      double price = double.tryParse(_productControllers[index]['price']?.text ?? '') ?? 0.0;
      _subtotal -= price;
      _productControllers.removeAt(index);
    });
  }

  void _updateSubtotal() {
    double subtotal = 0.0;
    for (var controllerMap in _productControllers) {
      double price = double.tryParse(controllerMap['price']?.text ?? '') ?? 0.0;
      subtotal += price;
    }
    setState(() {
      _subtotal = subtotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 10,
        centerTitle: true,
        title: Text('PRODUCT LIST'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _productControllers.length,
                  itemBuilder: (context, index) {
                    final controllers = _productControllers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 50,
                              width: 40,
                              decoration: BoxDecoration(

                              ),
                              child: TextFormField(
                                controller: controllers['product'],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Product Name',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a product name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 50,
                              width: 40,
                              decoration: BoxDecoration(

                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,

                                controller: controllers['price'],
                                decoration: InputDecoration(


                                  border: OutlineInputBorder(),
                                  labelText: 'Price',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a price';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _updateSubtotal();
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.dangerous_rounded),
                            onPressed: () {
                              _deleteProduct(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹$_subtotal',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0), // Add spacing between subtotal and button
                      SizedBox(
                        height: 35,
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Proceed to Pay",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            foregroundColor: Colors.blueAccent,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120,horizontal: 10),
        child: FloatingActionButton(
          onPressed: _addProductFields,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
