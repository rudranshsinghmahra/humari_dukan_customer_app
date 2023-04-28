import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:humari_dukan/widgets/custom_appbar.dart';
import 'package:order_tracker/order_tracker.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key, required this.documentSnapshot})
      : super(key: key);
  final DocumentSnapshot documentSnapshot;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  FirebaseServices services = FirebaseServices();

  List<TextDto> orderList = [
    TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
    TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
    TextDto("Your item has been picked up by courier partner.",
        "Tue, 29th Mar '22 - 5:00pm"),
  ];

  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
    TextDto("Your item has been received in the nearest hub to you.", null),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
  ];

  List<TextDto> deliveredList = [
    TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const CustomAppBar(
                appbarTitle: "Track Order", showShoppingCart: true),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          margin: EdgeInsets.zero,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 16, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Order#: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  widget.documentSnapshot['orderNumber'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 2),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 16, left: 10, right: 10),
                            child: ListView.builder(
                              itemCount:
                                  widget.documentSnapshot["products"].length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.documentSnapshot['products']
                                                [index]['productName'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              "Rs. ${widget.documentSnapshot['products'][index]['sellingPrice']}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
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
                                );
                              },
                            ),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 2),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 16, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Rating",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                RatingBar.builder(
                                  initialRating:
                                      widget.documentSnapshot['rating'],
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    services.updateRating(
                                        widget.documentSnapshot.reference.id,
                                        rating);
                                  },
                                  itemSize: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          margin: const EdgeInsets.only(top: 2),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 16, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Track Order",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                OrderTracker(
                                  status: Status.delivered,
                                  activeColor: Colors.green,
                                  inActiveColor: Colors.grey[300],
                                  orderTitleAndDateList: orderList,
                                  shippedTitleAndDateList: shippedList,
                                  outOfDeliveryTitleAndDateList:
                                      outOfDeliveryList,
                                  deliveredTitleAndDateList: deliveredList,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
