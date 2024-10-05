import 'package:coffe_app/dataModel.dart';

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  cartAdd(Product product) {
    var item = cart.firstWhere((element) => element.product.id == product.id,
        orElse: () => ItemInCart(product: product, quantity: 0));
    if (item.quantity == 0) {
      cart.add(ItemInCart(product: product, quantity: 1));
    } else {
      item.quantity++;
    }
  }

  cartRemove(Product product) {
    var item = cart.firstWhere((element) => element.product.id == product.id);
    if (item.quantity == 1) {
      cart.remove(item);
    } else {
      item.quantity--;
    }
  }

  cartClear() {
    cart.clear();
  }
  double get cartTotal {
    return cart.fold(0, (previousValue, element) {
      return previousValue + element.product.price * element.quantity;
    });
  }
}
