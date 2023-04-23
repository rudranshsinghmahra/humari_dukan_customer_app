import 'package:flutter/material.dart';
import 'package:humari_dukan/services/cart_provider.dart';
import 'package:provider/provider.dart';

class CustomShoppingCart extends StatelessWidget {
  const CustomShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Stack(
      children: [
        const Icon(
          Icons.shopping_bag_outlined,
          size: 40,
          color: Colors.white,
        ),
        Positioned(
          right: 0,
          child: ClipOval(
            child: Container(
              height: 20,
              width: 20,
              color: Colors.green,
              child: Center(
                child: Text(
                  "${cartProvider.cartQty}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
