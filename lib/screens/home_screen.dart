import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humari_dukan/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../services/cart_provider.dart';
import '../widgets/home_screen/home_screen_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartTotal();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Theme.of(context).primaryColor),
        child: const SafeArea(child: HomeScreenUI()),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
