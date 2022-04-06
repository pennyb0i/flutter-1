import 'dart:math';

import 'package:flutter/material.dart';

final _random = Random();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const Text('epic gamer moment')
        ),
        body: ListView.builder(itemBuilder: (_,index) {
          return Container(
            color: Color.fromRGBO(
                _random.nextInt(256),
                _random.nextInt(256),
                _random.nextInt(256),
                1.0),
            width: 50,
            height: 250,
            child: Center(
              child: SizedBox(
                width: null,
                height: null,
                child: ElevatedButton(
                  child: Text(
                    '$count + $index',
                    style: const TextStyle(fontSize: 60),
                  ),
                  onPressed: () {
                    setState(() {
                      count++;
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      count = 0;
                    });
                  },
                ),
              ),
            ),
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
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

