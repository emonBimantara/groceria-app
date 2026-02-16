import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:groceria/Controller/cart_controller.dart';
import 'package:groceria/Model/product_model.dart';

class CustomCartCard extends StatelessWidget {
  final ProductModel product;

  const CustomCartCard({super.key, required this.product});

  static final formatter = NumberFormat('#,###', 'id_ID');

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                product.imageUrls.isNotEmpty
                    ? product.imageUrls[0]
                    : 'https://placeholder.com/150',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Rp ${formatter.format(product.price.toInt())}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAD73),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Obx(() {
                    final amount = cartController.getAmount(product.id);
                    final subtotal = product.price * amount;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: amount == 0
                                  ? null
                                  : () =>
                                        cartController.removeFromCart(product),
                              child: Opacity(
                                opacity: amount == 0 ? 0.4 : 1,
                                child: const Icon(
                                  Icons.remove,
                                  color: Color(0xFF1A4B3C),
                                  size: 18,
                                ),
                              ),
                            ),

                            const SizedBox(width: 20),

                            Text(
                              amount.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(width: 20),

                            InkWell(
                              onTap: () => cartController.addToCart(product),
                              child: Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1A4B3C),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Rp ${formatter.format(subtotal.toInt())}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
