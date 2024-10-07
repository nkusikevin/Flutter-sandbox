import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/components/cart_item.dart';
import 'package:shoes_shop/models/cart.dart';
import 'package:shoes_shop/models/shoe.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
        builder: (context, value, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "My cart",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: ListView.builder(
                itemCount: value.getCartList().length,
                itemBuilder: (context, index) {
                  //get individal shoe
                  Shoe individualShoe = value.getCartList()[index];
                  return CartItem(shoe: individualShoe);
                },
              )),
            ])));
  }
}
