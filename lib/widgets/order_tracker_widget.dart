import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTrackerWidget extends StatefulWidget {
  const OrderTrackerWidget({Key? key, required this.documentSnapshot})
      : super(key: key);
  final DocumentSnapshot documentSnapshot;

  @override
  State<OrderTrackerWidget> createState() => _OrderTrackerWidgetState();
}

class _OrderTrackerWidgetState extends State<OrderTrackerWidget> {
  @override
  Widget build(BuildContext context) {
    var timestampPlacedDate = widget.documentSnapshot['orderPlacedOn'];
    var formattedPlacedDate = '';
    if (timestampPlacedDate != null) {
      formattedPlacedDate = DateFormat('dd-MM-yyyy, hh:mm a')
          .format(timestampPlacedDate.toDate());
    }

    var timestampProcessedOn = widget.documentSnapshot['orderProcessedOn'];
    var formattedProcessedDate = '';
    if (timestampProcessedOn != null) {
      formattedProcessedDate = DateFormat('dd-MM-yyyy, hh:mm a')
          .format(timestampProcessedOn.toDate());
    }

    var timestampPickedUpOn = widget.documentSnapshot['orderPickedUp'];
    var formattedPickedUpOn = '';
    if (timestampPickedUpOn != null) {
      formattedPickedUpOn = DateFormat('dd-MM-yyyy, hh:mm a')
          .format(timestampPickedUpOn.toDate());
    }

    var timestampShippedOn = widget.documentSnapshot['orderShippedOn'];
    var formattedShippedOn = '';
    if (timestampShippedOn != null) {
      formattedShippedOn =
          DateFormat('dd-MM-yyyy, hh:mm a').format(timestampShippedOn.toDate());
    }

    var timestampReachedNearestHubOn =
        widget.documentSnapshot['reachedNearestHubOn'];
    var formattedReachedNearestHubOn = '';
    if (timestampReachedNearestHubOn != null) {
      formattedReachedNearestHubOn = DateFormat('dd-MM-yyyy, hh:mm a')
          .format(timestampReachedNearestHubOn.toDate());
    }

    var timestampOutForDeliveryOn = widget.documentSnapshot['outForDeliveryOn'];
    var formattedOutForDeliveryOn = '';
    if (timestampOutForDeliveryOn != null) {
      formattedOutForDeliveryOn = DateFormat('dd-MM-yyyy, hh:mm a')
          .format(timestampOutForDeliveryOn.toDate());
    }

    var timestampDeliveredOn = widget.documentSnapshot['orderDeliveredOn'];
    var formattedDeliveredOn = '';
    if (timestampDeliveredOn != null) {
      formattedDeliveredOn = DateFormat('dd-MM-yyyy, hh:mm a')
          .format(timestampDeliveredOn.toDate());
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: widget.documentSnapshot['deliveryStatus'] ==
                                "Order Placed" ||
                            widget.documentSnapshot['deliveryStatus'] ==
                                "Order Processed" ||
                            widget.documentSnapshot['deliveryStatus'] ==
                                "Order Picked Up" ||
                            widget.documentSnapshot['deliveryStatus'] ==
                                "Reached Nearest Hub" ||
                            widget.documentSnapshot['deliveryStatus'] ==
                                "Order Shipped" ||
                            widget.documentSnapshot['deliveryStatus'] ==
                                "Out For Delivery" ||
                            widget.documentSnapshot['deliveryStatus'] ==
                                "Delivered"
                        ? Colors.green
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Container(
                  // In this container
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 3.0,
                        color: widget.documentSnapshot['deliveryStatus'] ==
                                    "Order Shipped" ||
                                widget.documentSnapshot['deliveryStatus'] ==
                                    "Out For Delivery" ||
                                widget.documentSnapshot['deliveryStatus'] ==
                                    "Delivered"
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Order Placed",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      formattedPlacedDate,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 5),
                    child: Text(
                      "Seller has processed your order",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      formattedProcessedDate,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 5),
                    child: Text(
                      "Your item has been picked up by the courier partner",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      formattedPickedUpOn,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: widget.documentSnapshot['deliveryStatus'] ==
                                "Order Shipped" ||
                            widget.documentSnapshot['deliveryStatus'] ==
                                "Out For Delivery" ||
                            widget.documentSnapshot['deliveryStatus'] ==
                                "Delivered"
                        ? Colors.green
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Container(
                  // In this container
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 3.0,
                        color: widget.documentSnapshot['deliveryStatus'] ==
                                    "Out For Delivery" ||
                                widget.documentSnapshot['deliveryStatus'] ==
                                    "Delivered"
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Shipped",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      formattedShippedOn,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 5),
                    child: Text(
                      "Your order has been shipped",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      formattedShippedOn,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 5),
                    child: Text(
                      "Your item has been received in the nearest hub to you",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      formattedReachedNearestHubOn,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: widget.documentSnapshot['deliveryStatus'] ==
                                "Out For Delivery" ||
                            widget.documentSnapshot['deliveryStatus'] ==
                                "Delivered"
                        ? Colors.green
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Container(
                  // In this container
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 3.0,
                        color: widget.documentSnapshot['deliveryStatus'] ==
                                "Delivered"
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Out for delivery",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      formattedOutForDeliveryOn,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 5),
                    child: Text(
                      "Your order is out for delivery",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color:
                        widget.documentSnapshot['deliveryStatus'] == "Delivered"
                            ? Colors.green
                            : Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Delivered",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      formattedDeliveredOn,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 5),
                    child: Text(
                      "Your order has been delivered",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
