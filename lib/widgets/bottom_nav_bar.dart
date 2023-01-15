import 'package:flutter/material.dart';
import 'package:humari_dukan/screens/home_screen.dart';
import 'package:humari_dukan/screens/settings_screen.dart';
import 'package:humari_dukan/screens/wishlisted_products_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(
          20,
        ),
      ),
      child: BottomAppBar(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffff4a85),
          ),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SettingScreen(),
                        transitionDuration: const Duration(seconds: 0),
                      ));
                },
                child: const Icon(
                  Icons.business_center,
                  color: Color(0xffe7e7e7),
                  size: 50,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => WishlistedProductScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
                child: const Icon(
                  Icons.shopping_bag,
                  color: Color(0xffe7e7e7),
                  size: 50,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: const Duration(seconds: 0),
                      ));
                },
                child: const Icon(
                  Icons.account_circle_rounded,
                  color: Color(0xffffe156),
                  size: 50,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SettingScreen(),
                        transitionDuration: const Duration(seconds: 0),
                      ));
                },
                child: const Icon(
                  Icons.settings,
                  color: Color(0xffe7e7e7),
                  size: 50,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SettingScreen(),
                        transitionDuration: const Duration(seconds: 0),
                      ));
                },
                child: const Icon(
                  Icons.more_horiz,
                  color: Color(0xffe7e7e7),
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
