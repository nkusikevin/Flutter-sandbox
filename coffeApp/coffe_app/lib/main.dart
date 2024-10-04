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
            seedColor: const Color.fromARGB(255, 44, 27, 1)),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Image.asset('images/logo.png')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const HelloWord(),
            const AbaBoys(),
          ],
        ),
      ),
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
