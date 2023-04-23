import 'package:flutter/material.dart';
import 'package:humari_dukan/screens/cart_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key, required this.appbarTitle, required this.showShoppingCart})
      : super(key: key);
  final String appbarTitle;
  final bool showShoppingCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color(0xffff4a85),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10, top: 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        appbarTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const CartScreen(),
                            transitionDuration: const Duration(seconds: 0)));
                  },
                  child: showShoppingCart
                      ? const Icon(
                          Icons.shopping_bag_outlined,
                          size: 40,
                          color: Colors.white,
                        )
                      : Container(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
