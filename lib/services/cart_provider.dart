import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:humari_dukan/services/firebase_services.dart';

class CartProvider extends ChangeNotifier {
  final FirebaseServices _cartServices = FirebaseServices();
  double subTotal = 0.0;
  int cartQty = 0;
  QuerySnapshot? snapshot;

  Future<double?> getCartTotal() async {
    double cartTotal = 0;
    QuerySnapshot snapshot = await _cartServices.cart
        .doc(_cartServices.user?.uid)
        .collection('cartItems')
        .get();
    if (snapshot == null) {
      return null;
    }
    for (var element in snapshot.docs) {
      cartTotal = cartTotal + element['total'];
    }
    subTotal = cartTotal;
    cartQty = snapshot.size;
    this.snapshot = snapshot;
    notifyListeners();
    return cartTotal;
  }
}
