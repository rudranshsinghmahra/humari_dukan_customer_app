import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humari_dukan/services/firebase_services.dart';

class CounterWidget extends StatefulWidget {
  CounterWidget({Key? key, required this.documentSnapshot}) : super(key: key);
  final DocumentSnapshot? documentSnapshot;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseServices services = FirebaseServices();
  bool _exists = false;
  int quantity = 1;
  String? docId;

  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      message: 'Product successfully added to cart!',
      contentType: ContentType.success,
      title: 'Success',
    ),
  );

  getCartDetails() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(user?.uid)
        .collection('cartItems')
        .where('sku', isEqualTo: widget.documentSnapshot?['sku'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          if (doc['sku'] == widget.documentSnapshot?['sku']) {
            //This means product is already added to cart
            if (mounted) {
              setState(() {
                _exists = true;
                quantity = doc['quantity'];
                docId = doc.id;
              });
            }
          } else {
            if (mounted) {
              setState(() {
                _exists = false;
              });
            }
          }
        });
      }
    });
  }

  @override
  void initState() {
    getCartDetails();
  }

  @override
  Widget build(BuildContext context) {
    return _exists
        ? StreamBuilder(
            stream: getCartDetails(),
            builder: ((context, snapshot) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (quantity == 1) {
                          services.removeItemFromCart(docId).then((value) {
                            setState(() {
                              _exists = false;
                            });
                          });
                        }
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                        var total =
                            quantity * widget.documentSnapshot?['sellingPrice'];
                        services.updateCartDetails(docId, quantity, total);
                      },
                      child: const Icon(
                        Icons.remove,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                        var total =
                            quantity * widget.documentSnapshot?['sellingPrice'];
                        services.updateCartDetails(docId, quantity, total);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              );
            }),
          )
        : StreamBuilder(
            stream: getCartDetails(),
            builder: ((context, snapshot) {
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      services
                          .addProductsToCart(
                              user?.uid,
                              widget.documentSnapshot?['productName'],
                              widget.documentSnapshot?['description'],
                              widget.documentSnapshot?['costPrice'],
                              widget.documentSnapshot?['sellingPrice'],
                              widget.documentSnapshot?['sku'],
                              1,
                              widget.documentSnapshot?['sellingPrice'])
                          .then(
                            (value) => {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar)
                            },
                          );
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffffe156)),
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
  }
}
