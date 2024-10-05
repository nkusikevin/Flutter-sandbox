// import 'dart:convert';

// import 'package:coffe_app/dataModel.dart';
// import 'package:http/http.dart' as http;

// class DataManager {
//   List<Category>? _menu;
//   List<ItemInCart> cart = [];

//   fetchMenu() async {
//     const url = 'https://firtman.github.io/coffeemasters/api/menu.json';
//     var response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var menuJson = response.body;
//       _menu = [];
//       var decodedMenu = jsonDecode(menuJson) as List<dynamic>;
//       for (var category in decodedMenu) {
//         _menu?.add(Category.fromJson(category));
//       }
//     } else {
//       throw Exception('Failed to load menu');
//     }
//   }

//   Future<List<Category>> getMenu() async {
//     if (_menu == null) {
//       fetchMenu();
//     }
//     return _menu!;
//   }

//   cartAdd(Product product) {
//     var item = cart.firstWhere((element) => element.product.id == product.id,
//         orElse: () => ItemInCart(product: product, quantity: 0));
//     if (item.quantity == 0) {
//       cart.add(ItemInCart(product: product, quantity: 1));
//     } else {
//       item.quantity++;
//     }
//   }

//   cartRemove(Product product) {
//     var item = cart.firstWhere((element) => element.product.id == product.id);
//     if (item.quantity == 1) {
//       cart.remove(item);
//     } else {
//       item.quantity--;
//     }
//   }

//   cartClear() {
//     cart.clear();
//   }

//   double get cartTotal {
//     return cart.fold(0, (previousValue, element) {
//       return previousValue + element.product.price * element.quantity;
//     });
//   }
// }

import 'dart:convert';
import 'package:coffe_app/dataModel.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  Future<void> fetchMenu() async {
    const url = 'https://firtman.github.io/coffeemasters/api/menu.json';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var menuJson = response.body;
      _menu = [];
      var decodedMenu = jsonDecode(menuJson) as List<dynamic>;
      for (var category in decodedMenu) {
        _menu!.add(Category.fromJson(category));
      }
    } else {
      throw Exception('Failed to load menu');
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu!;
  }

  void cartAdd(Product product) {
    var item = cart.firstWhere((element) => element.product.id == product.id,
        orElse: () => ItemInCart(product: product, quantity: 0));
    if (item.quantity == 0) {
      cart.add(ItemInCart(product: product, quantity: 1));
    } else {
      item.quantity++;
    }
  }

  void cartRemove(Product product) {
    var item = cart.firstWhere((element) => element.product.id == product.id);
    if (item.quantity == 1) {
      cart.remove(item);
    } else {
      item.quantity--;
    }
  }

  void cartClear() {
    cart.clear();
  }

  double cartTotal() {
    return cart.fold(0, (previousValue, element) {
      return previousValue + element.product.price * element.quantity;
    });
  }
}
