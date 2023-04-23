import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:humari_dukan/services/firebase_services.dart';

import '../cart_item_card.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> with TickerProviderStateMixin {
  FirebaseServices services = FirebaseServices();
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SpinKitFadingCube spinkit = SpinKitFadingCube(
      color: Colors.pink,
      size: 50.0,
      controller: animationController,
    );
    return StreamBuilder(
      stream: services.cart
          .doc(services.user?.uid)
          .collection("cartItems")
          .snapshots(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: spinkit,
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: spinkit,
          );
        }
        return ListView(
          children:
              snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
            return CardItemCard(
              documentSnapshot: documentSnapshot,
            );
          }).toList(),
        );
      }),
    );
  }
}
