// import 'dart:ffi';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter_1/Models/products.dart';

void main() => runApp(const Produit());

class Produit extends StatelessWidget {
  const Produit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AB project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ProduitPage(),
    );
  }
}

class ProduitPage extends StatefulWidget {
  const ProduitPage({Key? key}) : super(key: key);

  @override
  State<ProduitPage> createState() => _ProduitPageState();
}

class _ProduitPageState extends State<ProduitPage> {
  late Future<List<Products>> futureProducts;
  // TextEditingController nameController = TextEditingController();
  // TextEditingController priceController = TextEditingController();
  
  Future<List<Products>> fetchProducts() async {
    // final name = nameController.text;
    // final price = priceController.text;

    final response = await http.get(Uri.parse('http://10.0.2.2:3000/products'));

    if (response.statusCode == 200) {
      List<dynamic> productsJson = jsonDecode(response.body);
      List<Products> products = productsJson.map((productJson) => Products.fromJson(productJson)).toList();
      return products;
    } else {
      throw Exception('Echec lors du chargement des produits');
    }
  }

  Future<Products> deleteProducts(int id) async {
    final response = await http.delete(Uri.parse('http://10.0.2.2:3000/products/delete/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Products.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Je ne peux pas.');
    }
  }

  Future<Products> updateProducts(String name, double price, int id) async {
    final response = await http.put(Uri.parse('http://10.0.2.2:3000/products/modifier/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'price': price,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Products.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Je ne peux pas.');
    }
  }

  Future<Products> createProducts(String name, double price, int categories_id, String description, 
  String image, int quantity) async {
    final response = await http.post(Uri.parse('http://10.0.2.2:3000/products/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'price': price,
        'categories_id': categories_id,
        'description': description,
        'image': image,
        'quantity':quantity,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Products.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Je ne peux pas.');
    }
  }

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  void dialogue_1(Products product) {

    String newName = product.name;
    double newPrice = product.price;

    showDialog(

    context: context, 
    builder: (context) => AlertDialog(
      title: const Text('Modification'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: product.name,
            decoration: InputDecoration(
              hintText: 'Nom',
            ),
            onChanged: (value) {
              newName = value;
            },
          ),
          TextFormField(
            initialValue: product.price.toString(),
            decoration: InputDecoration(
              hintText: 'Prix',
            ),
            onChanged: (value) {
              newPrice = double.tryParse(value) ?? product.price;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Supprimer'),
          onPressed: () {
            deleteProducts(product.id);
            Navigator.pushNamed(context, '/produit');
          }
        ),
        TextButton(
          child: const Text('Valider'),
          onPressed: () {
            updateProducts(newName, newPrice, product.id);
            Navigator.pushNamed(context, '/produit');
          }
        ),
      ],
    ),
  );
  }

  @override
  void dialogue_2() {

    int createCategories_id = 1;
    String createName = "";
    String createDescription = "";
    String createImage = "";
    double createPrice = 1;
    int createQuantity = 0;

    showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: const Text('Creation'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Nom',
            ),
            onChanged: (value) {
              createName = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Prix',
            ),
            onChanged: (value) {
              createPrice = double.tryParse(value) ?? 1;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Image',
            ),
            onChanged: (value) {
              createImage = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Description',
            ),
            onChanged: (value) {
              createDescription = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'categories_id',
            ),
            onChanged: (value) {
              createCategories_id = int.tryParse(value) ?? 0;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Quantité',
            ),
            onChanged: (value) {
              createQuantity = int.tryParse(value) ?? 0;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Valider'),
          onPressed: () {
            createProducts(createName, createPrice, createCategories_id, createImage, createDescription , createQuantity);
            Navigator.pushNamed(context, '/produit');
          }
          ),
      ],
    ),
  );
  }

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Products>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Products product = snapshot.data![index];
                    return Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          width: 220,
                          height: 230,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF8b4513),
                                Color(0xFFDEB887),
                              ]
                            ),
                          ),
                          child: Column(
                              children: [
                                    IconButton(
                                      iconSize: 15.0,
                                      color: Colors.white,
                                      icon: const Icon(
                                        Icons.edit
                                      ), 
                                      onPressed: () {
                                        dialogue_1(product);
                                      },
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(100))
                                      ),
                                      child: Image.asset('assets/images/${product.image}',
                                        errorBuilder: ( context, error, stackTrace) {
                                        return Image.network('${product.image}',
                                        errorBuilder: ( context, error, stackTrace) {
                                        return Container(
                                            width: 20,
                                            height: 20,
                                            color: Color(0xFF8b4513),
                                          );
                                          }
                                        );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      product.name, 
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}', 
                                      style: const TextStyle(
                                          color: Colors.white,
                                      ),
                                    ),
                                  ],
                            ),
                        ),
                          SizedBox(height: 30),
                      ],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Color(0xFF8b4513),
        child : const Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          dialogue_2();
        },
      ),
    );
  }
}
