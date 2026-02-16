import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:groceria/Components/custom_cart_card.dart';
import 'package:groceria/Controller/cart_controller.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  Text(
                    'My Cart',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      cartController.clearCart();
                    },
                    child: Icon(Icons.delete),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                if (cartController.cart.isEmpty) {
                  return const Center(child: Text("Cart masih kosong"));
                }

                final items = cartController.cart.values.toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final cartItem = items[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CustomCartCard(product: cartItem.product),
                    );
                  },
                );
              }),
            ),

            Obx(() {
              final total = cartController.totalPrice;
              final formatter = NumberFormat('#,###', 'id_ID');

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Rp ${formatter.format(total.toInt())}",
                      style: TextStyle(
                        color: Color(0xFF1A4B3C),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: 15),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF1A4B3C),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "Proceed to checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
