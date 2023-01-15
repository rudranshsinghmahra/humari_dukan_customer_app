import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:humari_dukan/widgets/bottom_nav_bar.dart';
import 'package:humari_dukan/widgets/cart_item_card.dart';
import 'package:humari_dukan/widgets/custom_appbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseServices services = FirebaseServices();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const CustomAppBar(appbarTitle: "Cart"),
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
                    children: const [
                      Text(
                        "Total:",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$672",
                        style: TextStyle(
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
            Padding(
              padding: const EdgeInsets.only(top: 250, left: 10, right: 10),
              child: StreamBuilder(
                stream: services.cart
                    .doc(user?.uid)
                    .collection("cartItems")
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot documentSnapshot) {
                      return CardItemCard(
                        documentSnapshot: documentSnapshot,
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
