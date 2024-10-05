import 'package:coffe_app/dataModel.dart';
import 'package:coffe_app/datamanager.dart';
import 'package:coffe_app/pages/offerspage.dart';
import 'package:coffe_app/pages/menupage.dart';
import 'package:coffe_app/pages/orderspage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee on Move',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 93, 47, 2)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataManager = DataManager();
  var selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = MenuPage(dataManager: dataManager);

    switch (selectedPage) {
      case 0:
        currentWidget = MenuPage(dataManager: dataManager);
        break;
      case 1:
        currentWidget = const OffersPage();
        break;
      case 2:
        currentWidget = OrderPage(dataManager: dataManager);
        break;
      default:
        currentWidget = const HelloWord();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Image.asset(
          'images/logo.png',
          height: 800,
          width: 800,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Colors.yellow.shade100,
          unselectedItemColor: Colors.brown.shade100,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.coffee),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_checkout),
              label: 'Cart',
            ),
          ]),
      body: currentWidget,
    );
  }
}

class HelloWord extends StatelessWidget {
  const HelloWord({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Good Evening!',
      style: TextStyle(
        color: Colors.green,
        fontSize: 24,
      ),
    );
  }
}

class AbaBoys extends StatefulWidget {
  const AbaBoys({super.key});

  @override
  State<AbaBoys> createState() => _AbaBoysState();
}

class _AbaBoysState extends State<AbaBoys> {
  var name = "";
  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      color: const Color.fromARGB(255, 1, 34, 56),
      fontSize: 24,
    );
    return Column(children: [
      Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                "Hello $name",
                style: style,
              )),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(24),
        child: TextField(
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        ),
      ),
    ]);
  }
}
