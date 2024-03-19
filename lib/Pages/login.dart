import 'package:flutter/material.dart';
import 'package:flutter_1/Models/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_1/Pages/products.dart';

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AB project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController gmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void connexion() async {
    if (_formKey.currentState!.validate()) {
      final email = gmailController.text;
      final password = passwordController.text;

      final response = await http.post( Uri.parse('http://10.0.2.2:3000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Connexion réussie, vous pouvez naviguer vers la page suivante
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProduitPage()),
        );
      } else {
        // Connexion échouée
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Informations d\'identification incorrectes')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF8b4513),
                Color(0xFF000000),
              ]
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(
              top: 80.0, 
              left: 20.0,
            ),
            child: Text(
              'Connexion',
              style: TextStyle(
              fontSize: 40, 
              fontWeight: FontWeight.bold, 
              color: Colors.white
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0, left: 20, right: 20,),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: gmailController,
                      decoration: const InputDecoration(
                        label: Text('Gmail',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8b4513),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Password', 
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8b4513),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40,),
                    Container(
                      height: 44.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF8b4513),
                            Color(0xFF000000),
                          ]
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                           connexion();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: const Text ('Connexion',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        ],
      )
    );
  }
}
// 2 input 2 controller