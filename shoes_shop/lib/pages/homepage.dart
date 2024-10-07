import 'package:flutter/material.dart';
import 'package:shoes_shop/components/bottom_nav.dart';
import 'package:shoes_shop/pages/cart_page.dart';
import 'package:shoes_shop/pages/shopping_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ShoppingPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomNav(
        onTabChange: (index) {
          navigateBottomBar(index);
        },
      ),
      body: _pages[_selectedIndex],
    );
  }
}
