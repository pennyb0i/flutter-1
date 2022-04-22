import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_1/route_generator.dart';

import 'entities/contact.dart';

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
    return const MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class ContactEntry extends StatefulWidget {
  final Contact contact;
  const ContactEntry ({Key? key,  required this.contact}) : super(key: key);

  @override
  State<ContactEntry> createState() => _ContactEntryState();
}

class _ContactEntryState extends State<ContactEntry> {
  static const mainTxtStyle = TextStyle(fontSize: 20, color: Colors.blueGrey);
  static const descTxtStyle = TextStyle(fontSize: 12, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/details',
          arguments: widget.contact,
        );
      },
      leading: const Icon(Icons.account_box),
      title: Text(widget.contact.name,style: mainTxtStyle),
      subtitle: Row(
        children: [
          Text(widget.contact.number,style: descTxtStyle),
          Text(widget.contact.country,style: descTxtStyle),
        ],
      ),
      trailing: IconButton(icon: const Icon(Icons.call, color: Colors.green,),
        onPressed: () {
          dev.log("Beepboop!");
        },),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Contacts')
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (_,index) {
            return ContactEntry(contact: contacts[index]);
          }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F0F0F),
        unselectedItemColor: Colors.white38,
        selectedItemColor: Colors.blueGrey,
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/details',
            arguments: const Contact('', '', ''),
          );
        },
      ),
    );
  }
}




