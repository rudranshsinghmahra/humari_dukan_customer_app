import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:humari_dukan/widgets/bottom_nav_bar.dart';
import 'package:humari_dukan/widgets/counter.dart';
import 'package:humari_dukan/widgets/custom_appbar.dart';

import '../widgets/custom_progress_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, this.documentSnapshot})
      : super(key: key);
  final DocumentSnapshot? documentSnapshot;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  FirebaseServices services = FirebaseServices();
  User? user = FirebaseAuth.instance.currentUser;
  bool isWishListed = false;
  int quantity = 1;

  Future getWishlistedItemData() async {
    await services.wishlists
        .doc(user?.uid)
        .collection("favourite")
        .doc(widget.documentSnapshot?['sku'])
        .get()
        .then(
          (DocumentSnapshot dSnapshot) =>
              {isWishListed = dSnapshot['isWishlisted']},
        )
        .catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future setWishlistedItemData() async {
      await services.wishlists
          .doc(user?.uid)
          .collection("favourite")
          .doc(widget.documentSnapshot?['sku'])
          .get()
          .then(
            (DocumentSnapshot dSnapshot) => {
              if (dSnapshot.exists)
                {
                  services.wishlists
                      .doc(user?.uid)
                      .collection("favourite")
                      .doc(widget.documentSnapshot?['sku'])
                      .update(
                    {
                      'isWishlisted': true,
                    },
                  )
                }
              else
                {
                  services.wishlists
                      .doc(user?.uid)
                      .collection("favourite")
                      .doc(widget.documentSnapshot?['sku'])
                      .update(
                    {
                      'isWishlisted': false,
                    },
                  )
                }
            },
          );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Container(
                    color: const Color(0xfffee356),
                    height: 30,
                  ),
                  Container(
                    color: const Color(0xfffee356),
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset(
                        "assets/perfume.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    color: const Color(0xfffee356),
                    height: 30,
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: getWishlistedItemData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: spinKit(this),
                  );
                }
                return Positioned(
                    top: 70,
                    right: 20,
                    child: FavoriteButton(
                      isFavorite: isWishListed,
                      valueChanged: (isFavourite) {
                        if (isFavourite) {
                          services
                              .addProductToWishList(
                                user?.uid,
                                widget.documentSnapshot?['productName'],
                                widget.documentSnapshot?['description'],
                                widget.documentSnapshot?['costPrice'],
                                widget.documentSnapshot?['sellingPrice'],
                                widget.documentSnapshot?['sku'],
                              )
                              .then((value) => {setWishlistedItemData()});
                        } else {
                          services
                              .deleteWishlistedProduct(
                                widget.documentSnapshot?['sku'],
                              )
                              .then((value) => {setWishlistedItemData()});
                        }
                      },
                    ));
              },
            ),
            CustomAppBar(appbarTitle: widget.documentSnapshot?['productName'],showShoppingCart: true,),
            Padding(
              padding: const EdgeInsets.only(top: 360.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(
                      30,
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 22.0, left: 22, right: 22),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.documentSnapshot?['productName'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                            widget.documentSnapshot?['isLiquid'] == true
                                ? const Text(
                                    "50 ML",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 22),
                                  )
                                : Container()
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(
                              "Rs ${widget.documentSnapshot?['sellingPrice']}",
                              style: const TextStyle(
                                color: Color(0xffff4a85),
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.documentSnapshot?['description'],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            CounterWidget(
                              documentSnapshot: widget.documentSnapshot,
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
