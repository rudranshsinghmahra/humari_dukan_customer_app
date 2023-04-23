import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:humari_dukan/services/firebase_services.dart';

import '../../screens/product_details_screen.dart';
import '../counter.dart';

class ProductListHomeScreen extends StatefulWidget {
  const ProductListHomeScreen({Key? key}) : super(key: key);

  @override
  State<ProductListHomeScreen> createState() => _ProductListHomeScreenState();
}

class _ProductListHomeScreenState extends State<ProductListHomeScreen>
    with TickerProviderStateMixin {
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
    return StreamBuilder<QuerySnapshot>(
      stream: services.products.snapshots(),
      builder: (context, snapshot) {
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
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8, crossAxisCount: 2),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => ProductDetailsScreen(
                      documentSnapshot: snapshot.data!.docs[index],
                    ),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 8),
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.asset(
                          "assets/choose_image.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      snapshot.data?.docs[index]['productName'],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          "Rs ${snapshot.data?.docs[index]['sellingPrice']}",
                          style: const TextStyle(
                              color: Color(0xffff4a85),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Rs ${snapshot.data?.docs[index]['costPrice']}",
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 4, left: 20, right: 20),
                      child: Row(
                        children: [
                          const Spacer(),
                          CounterWidget(
                            documentSnapshot: snapshot.data!.docs[index],
                          ),
                          const Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
