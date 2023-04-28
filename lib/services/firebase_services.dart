import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:humari_dukan/services/cart_provider.dart';
import 'package:intl/intl.dart';

class FirebaseServices {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference products =
      FirebaseFirestore.instance.collection("products");
  CollectionReference wishlists =
      FirebaseFirestore.instance.collection("wishlists");
  CollectionReference cart = FirebaseFirestore.instance.collection("cart");
  CollectionReference address =
      FirebaseFirestore.instance.collection("address");
  CollectionReference orders = FirebaseFirestore.instance.collection("orders");

  User? user = FirebaseAuth.instance.currentUser;

  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return credential;
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return credential;
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future saveUserDetailsToDatabase(userUid, String email, String password,
      String name, String phoneNumber) async {
    await users.doc(userUid).set({
      "name": name,
      "email": email.toLowerCase().trim(),
      "password": password.trim(),
      "phoneNumber": phoneNumber,
      "userUid": userUid
    });
  }

  Future addProductToWishList(userUid, String productName, String description,
      int costPrice, int sellingPrice, String sku) async {
    await wishlists.doc(userUid).collection("favourite").doc(sku).set({
      "productName": productName,
      "description": description,
      "costPrice": costPrice,
      "sellingPrice": sellingPrice,
      "userUid": userUid,
      "sku": sku,
      "isWishlisted": true,
    });
  }

  Future deleteWishlistedProduct(String sku) async {
    wishlists.doc(user?.uid).collection("favourite").doc(sku).delete();
  }

  Future removeItemFromCart(docId) async {
    cart.doc(user?.uid).collection("cartItems").doc(docId).delete();
  }

  Future updateCartDetails(docId, quantity, total) async {
    await cart.doc(user?.uid).collection('cartItems').doc(docId).update({
      'quantity': quantity,
      'total': total,
    });
  }

  Future addProductsToCart(
      userUid,
      String productName,
      String description,
      int costPrice,
      int sellingPrice,
      String sku,
      int quantity,
      int total) async {
    await cart.doc(userUid).collection("cartItems").doc().set({
      "productName": productName,
      "description": description,
      "costPrice": costPrice,
      "sellingPrice": sellingPrice,
      "userUid": userUid,
      "sku": sku,
      "quantity": quantity,
      "total": total
    });
  }

  Future addAddressToDatabase(
    String recipientName,
    String houseNumber,
    String locality,
    String city,
    String state,
    String pinCode,
    String country,
    String addressType,
  ) async {
    await address.doc(user?.uid).collection(addressType).doc().set(
      {
        "recipientName": recipientName,
        "houseNumber": houseNumber,
        "locality": locality,
        "city": city,
        "state": state,
        "pinCode": pinCode,
        "country": country,
      },
    );
  }

  Future<String> generateOrderNumber() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('ddMMyyyy-HHmmss');
    final String formattedDateTime = formatter.format(now);

    final String orderNumber =
        'ORD-$formattedDateTime-${user?.uid.substring(0, 5)}';

    return orderNumber;
  }

  Future placeOrder(double total, CartProvider cartProvider) async {
    await generateOrderNumber().then((orderNumber) => {
          orders.doc().set({
            "deliveryStatus": "Order Placed",
            "total": total,
            "products": cartProvider.cartList,
            "timestamp": DateTime.now(),
            "userId": user?.uid,
            "rating": 0.0,
            "orderNumber": orderNumber,
          }).then((value) {
            deleteCart();
          })
        });
  }

  Future deleteCart() async {
    await cart.doc(user?.uid).collection('cartItems').get().then(
      (snapshot) {
        for (DocumentSnapshot documentSnapshot in snapshot.docs) {
          documentSnapshot.reference.delete();
        }
      },
    );
  }

  Future updateRating(documentId, double rating) async {
    await orders.doc(documentId).update({
      "rating": rating,
    });
  }
}
