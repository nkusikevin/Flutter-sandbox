import 'package:flutter/material.dart';
import 'package:shoes_shop/models/shoe.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(
        name: "AIR DT MAX '96",
        price: "\$150",
        imagePath: "images/AIR+DT+MAX+'96.png",
        description:
            "The Nike Air Max 90 stays true to its OG roots with its iconic Waffle outsole."),
    Shoe(
        name: "AIR MAX DN",
        price: "\$150",
        imagePath: "images/AIR+MAX+DN.png",
        description:
            "The Nike Air Max 90 stays true to its OG roots with its iconic Waffle outsole."),
    Shoe(
        name: "G.T. HUSTLE 3",
        price: "\$150",
        imagePath: "images/G.T.+HUSTLE+3.jpeg",
        description:
            "The Nike Air Max 90 stays true to its OG roots with its iconic Waffle outsole."),
    Shoe(
        name: "NIKE AIR MAX PLUS UTILITY",
        price: "\$150",
        imagePath: "images/NIKE+AIR+MAX+PLUS+UTILITY.png",
        description:
            "The Nike Air Max 90 stays true to its OG roots with its iconic Waffle outsole."),
    Shoe(
        name: "NIKE REACTX INFINITY RUN 4",
        price: "\$150",
        imagePath: "images/NIKE+REACTX+INFINITY+RUN+4.png",
        description:
            "The Nike Air Max 90 stays true to its OG roots with its iconic Waffle outsole."),
    Shoe(
        name: "PEGASUS PLUS",
        price: "\$150",
        imagePath: "images/PEGASUS+PLUS.png",
        description:
            "The Nike Air Max 90 stays true to its OG roots with its iconic Waffle outsole."),
  ];

  List<Shoe> cart = [];

  //get shoe list  
  List<Shoe> getShoeList() {
    return shoeShop;
  }

  //get cart list 
  List<Shoe> getCartList() {
    return cart;
  }

  //add to cart

  void addToCart(Shoe shoe) {
    cart.add(shoe);
    notifyListeners();
  }


  //remove from cart

  void removeFromCart(Shoe shoe) {
    cart.remove(shoe);
    notifyListeners();
  }


}
