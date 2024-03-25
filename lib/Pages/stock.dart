import 'package:flutter/material.dart';
import 'package:flutter_1/Models/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter_1/Pages/products.dart';


void main() => runApp(const Stock());


class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AB project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Stock(),
    );
  }
}

class _StockState extends State<Stock> {
  late Future<List<Products>> productsMax;
  late Future<List<Products>> productsMin;

  Future<List<Products>> maxProducts() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/products/stocks/haut'));

    if (response.statusCode == 200) {
      List<dynamic> productsJson = jsonDecode(response.body);
      List<Products> products = productsJson.map((productJson) => Products.fromJson(productJson)).toList();
      return products;
    } else {
      throw Exception('Echec lors du chargement du produit');
    }
  }

  Future<List<Products>> minProducts() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/products/stocks/bas'));

    if (response.statusCode == 200) {
      List<dynamic> productsJson = jsonDecode(response.body);
      List<Products> products = productsJson.map((productJson) => Products.fromJson(productJson)).toList();
      return products;
    } else {
      throw Exception('Echec lors du chargement du produit');
    }
  }

  @override
  void initState() {
    super.initState();
    productsMax = maxProducts();
    productsMin = minProducts();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Accueil',
      style: optionStyle,
    ),
    Text(
      'Stock',
      style: optionStyle,
    ),
  ];
  void _itemClique(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        // Naviguer vers la page d'accueil
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Produit()),
        );
      } else if (index == 1) {
        // Naviguer vers la page de stock
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Stock()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            FutureBuilder<List<Products>>(
              future: productsMax,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Products product = snapshot.data![index];
                        return Column(
                          children: [
                            SizedBox(height: 20,),
                            Container(
                              width: 220,
                              height: 200,
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
                                  SizedBox(height: 20,),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(100))
                                    ),
                                    child: Image.asset('assets/images/${product.image}',
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.network('${product.image}',
                                          errorBuilder: (context, error, stackTrace) {
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
                                    '\Stock : ${product.quantity}',
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
            FutureBuilder<List<Products>>(
              future: productsMin,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Products product = snapshot.data![index];
                        return Column(
                          children: [
                            SizedBox(height: 20,),
                            Container(
                              width: 220,
                              height: 200,
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
                                  SizedBox(height: 20,),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(100))
                                    ),
                                    child: Image.asset('assets/images/${product.image}',
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.network('${product.image}',
                                          errorBuilder: (context, error, stackTrace) {
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
                                    '\Stock : ${product.quantity}',
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_convenience_store),
            label: 'Stock',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _itemClique,
        selectedItemColor: Color.fromARGB(255, 126, 61, 23),
      ),
    );
  }
}
