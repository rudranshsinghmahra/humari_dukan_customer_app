import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:humari_dukan/widgets/bottom_nav_bar.dart';
import 'package:humari_dukan/widgets/cart/cart_list.dart';
import 'package:humari_dukan/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../services/cart_provider.dart';
import 'checkout_screen.dart';
import 'order_placed_screen.dart';

class CartScreen extends StatefulWidget {
  static String id = "cart_screen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseServices services = FirebaseServices();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const CustomAppBar(appbarTitle: "Cart",showShoppingCart: false),
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${cartProvider.subTotal}",
                        style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffdf4d)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 160, left: 40, right: 40),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckoutScreen(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffff4a85),
                        borderRadius: BorderRadius.circular(10)),
                    width: 300,
                    height: 80,
                    child: const Center(
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 250, left: 10, right: 10),
              child: CartList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
