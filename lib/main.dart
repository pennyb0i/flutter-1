import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

final _random = Random();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("We made a fucky wucky!");
          }
          else if (snapshot.hasData) {
            return const HomePage();
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF0F0F0F),
        appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const Text('epic gamer moment')
        ),
        body: ListView.builder(itemBuilder: (_,index) {
          return const ContactEntry();
        }),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF0F0F0F),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined),
              activeIcon: Icon(Icons.account_box),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              activeIcon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              activeIcon: Icon(Icons.message),
              label: 'Messages',
            )
          ],
        ),
        drawer: const Drawer(
          child: Icon(Icons.add_to_drive),
        ),
      ),
    );
  }
}

class ContactEntry extends StatelessWidget {
  const ContactEntry({Key? key}) : super(key: key);

  static const mainTxtStyle = TextStyle(fontSize: 20, color: Colors.blueGrey);
  static const descTxtStyle = TextStyle(fontSize: 12, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 2.0),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: const [
                    Text("name", style: mainTxtStyle),
                  ],
                ),
              ),
              Row(
                children: const [
                  Text("number ", style: descTxtStyle),
                  Text("country", style: descTxtStyle),
                ],
              ),
            ],
          ),
          const Icon(Icons.account_box, size: 50),
        ],
      ),
    );
  }
}



