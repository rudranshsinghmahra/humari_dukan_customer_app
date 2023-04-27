import 'package:flutter/material.dart';
import 'package:humari_dukan/screens/change_address_screen.dart';
import 'package:humari_dukan/screens/order_placed_screen.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:provider/provider.dart';

import '../services/cart_provider.dart';
import '../widgets/address_widget.dart';
import '../widgets/custom_appbar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with TickerProviderStateMixin {
  String? deliveryType = "";
  FirebaseServices services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    print(deliveryType);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                appbarTitle: "Checkout",
                showShoppingCart: false,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delivery Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChangeAddressScreen()));
                      },
                      child: const Text(
                        "Change",
                        style:
                            TextStyle(color: Color(0xffff4a85), fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  height: 100,
                  child: AddressWidget(),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                child: Text(
                  "Delivery Options",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.pink,
                        value:
                            deliveryType == 'Free Delivery (Standard Delivery)',
                        shape: const StadiumBorder(),
                        onChanged: (newValue) {
                          cartProvider.total = cartProvider.subTotal;
                          setState(() {
                            deliveryType = newValue == true
                                ? 'Free Delivery (Standard Delivery)'
                                : "";
                          });
                        },
                      ),
                      Row(
                        children: const [
                          Text(
                            'FREE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            ' Standard Delivery',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        shape: const StadiumBorder(),
                        activeColor: Colors.pink,
                        value: deliveryType == 'Rs 100 (Express Delivery)',
                        onChanged: (newValue) {
                          cartProvider.total = cartProvider.subTotal + 100;
                          setState(() {
                            deliveryType =
                                newValue! ? 'Rs 100 (Express Delivery)' : "";
                          });
                        },
                      ),
                      Row(
                        children: const [
                          Text(
                            '₹100',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            ' Express Delivery',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                child: Text(
                  "Payment Method",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Container(
                color: Colors.grey.shade100,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Subtotal",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                          Text(
                            "Rs. ${cartProvider.subTotal}",
                            style: const TextStyle(
                                color: Color(0xffff4a85), fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Shipping",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                          Text(
                            deliveryType == "Rs 100 (Express Delivery)"
                                ? "Rs 100"
                                : "FREE",
                            style: const TextStyle(
                                color: Color(0xffff4a85), fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            deliveryType == ""
                                ? "Select Delivery Option"
                                : "Rs. ${cartProvider.total}",
                            style: const TextStyle(
                                color: Color(0xffff4a85),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: GestureDetector(
                  onTap: () {
                    if (deliveryType != "") {
                      if (deliveryType == "Free Delivery (Standard Delivery)") {
                        services
                            .placeOrder(cartProvider.total + 100, cartProvider)
                            .then((value) => {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const OrderPlacedScreen(),
                                      ),
                                      (route) => false),
                                });
                      } else if (deliveryType == "Rs 100 (Express Delivery)") {
                        services
                            .placeOrder(cartProvider.total, cartProvider)
                            .then(
                              (value) => {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OrderPlacedScreen(),
                                    ),
                                    (route) => false)
                              },
                            );
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffff4a85),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Make Payment",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
