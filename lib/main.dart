import 'package:flutter/material.dart';

// Importation des pages
import 'package:flutter_1/Pages/login.dart';
import 'package:flutter_1/Pages/products.dart';
import 'package:flutter_1/Pages/stock.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
      ),
      initialRoute: '/produit',
      routes: {
        '/': (context) => const Login(),
        '/produit': (context) => const Produit(),
        '/stock': (context) => const Stock(),
      },
    );
  }
}

