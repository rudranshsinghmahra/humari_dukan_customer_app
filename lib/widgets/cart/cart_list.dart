import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:humari_dukan/services/firebase_services.dart';

import '../cart_item_card.dart';
import '../custom_progress_indicator.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> with TickerProviderStateMixin {
  FirebaseServices services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: services.cart
          .doc(services.user?.uid)
          .collection("cartItems")
          .snapshots(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: spinKit(this),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: spinKit(this),
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
