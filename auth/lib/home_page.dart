import 'package:auth/components/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentify'),
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Ionicons.log_out_outline))
        ],
        backgroundColor: Colors.grey[100],
        shadowColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 50, color: Colors.green),
            const SizedBox(height: 20),
            const Text('You are logged in!', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text('Names: ${user.displayName ?? "No Users Name available" }', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
