import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:humari_dukan/screens/order_details_screen.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:humari_dukan/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';

class MyPurchasesScreen extends StatefulWidget {
  const MyPurchasesScreen({Key? key}) : super(key: key);

  @override
  State<MyPurchasesScreen> createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends State<MyPurchasesScreen>
    with TickerProviderStateMixin {
  FirebaseServices firebaseServices = FirebaseServices();
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const CustomAppBar(
              appbarTitle: "My Purchases",
              showShoppingCart: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: firebaseServices.orders
                          .where("userId",
                              isEqualTo: firebaseServices.user?.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return spinkit;
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              "No purchases made till now...",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            var timestamp =
                                snapshot.data?.docs[index]['timestamp'];
                            var formattedDate =
                                DateFormat('dd-MM-yyyy, hh:mm a')
                                    .format(timestamp.toDate());
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 12.0, right: 12),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4, top: 5, bottom: 2),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailsScreen(
                                          documentSnapshot:
                                              snapshot.data!.docs[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    shadowColor: Colors.pink,
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Order: ${snapshot.data?.docs[index]['orderNumber']}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  Text(
                                                    formattedDate,
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image.network(
                                                  "https://usapple.org/wp-content/uploads/2019/10/apple-empire.png",
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Estimated Delivery on 21 Dec",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                              RatingBar.builder(
                                                initialRating: snapshot.data
                                                    ?.docs[index]['rating'],
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  firebaseServices.updateRating(
                                                      snapshot.data?.docs[index]
                                                          .reference.id,
                                                      rating);
                                                },
                                                itemSize: 20,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
