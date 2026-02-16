import 'package:get/state_manager.dart';
import 'package:groceria/Model/product_model.dart';

class CartItem {
  final ProductModel product;
  int amount;

  CartItem({required this.product, required this.amount});
}

class CartController extends GetxController {
  var cart = <String, CartItem>{}.obs;

  void addToCart(ProductModel product) {
    if (cart.containsKey(product.id)) {
      cart[product.id]!.amount++;
      cart.refresh();
    } else {
      cart[product.id] = CartItem(product: product, amount: 1);
    }
  }

  void removeFromCart(ProductModel product) {
    if (!cart.containsKey(product.id)) return;

    if (cart[product.id]!.amount > 1) {
      cart[product.id]!.amount--;
      cart.refresh();
    } else {
      cart.remove(product.id);
    }
  }

  int getAmount(String productId) {
    return cart[productId]?.amount ?? 0;
  }

  // int get totalItem {
  //   int total = 0;
  //   cart.forEach((key, value) {
  //     total += value.amount;
  //   });
  //   return total;
  // }

  double get totalPrice {
    double total = 0;
    cart.forEach((key, item) {
      total += item.product.price * item.amount;
    });
    return total;
  }

  void clearCart(){
    cart.clear();
    cart.refresh();
  }

}
