import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Puzzle',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: MyHomePage(),
    );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}


class MyHomePageState extends State<MyHomePage> {

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
              top: 30.0, 
              left: 20.0,
            ),
            child: Text(
              'Connexion',
              style: TextStyle(
              fontSize: 25, 
              fontWeight: FontWeight.bold, 
              color: Colors.white
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120.0),
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
              padding: const EdgeInsets.only(top: 70.0, left: 20, right: 20,),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Gmail',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8b4513),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Password', 
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8b4513),
                        ),
                      ),
                    )
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    width: 200,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF8b4513),
                          Color(0xFF000000),
                        ]
                      ),
                    ),
                    child: const Center (child: Text('Connexion', 
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
        )
        ],
      )
    );
  }
}