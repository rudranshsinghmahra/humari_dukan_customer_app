import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:humari_dukan/widgets/bottom_nav_bar.dart';
import 'package:humari_dukan/widgets/custom_appbar.dart';


class WishlistedProductScreen extends StatefulWidget {
  const WishlistedProductScreen({Key? key}) : super(key: key);

  @override
  State<WishlistedProductScreen> createState() =>
      _WishlistedProductScreenState();
}

class _WishlistedProductScreenState extends State<WishlistedProductScreen>
    with TickerProviderStateMixin {
  FirebaseServices services = FirebaseServices();
  User? user = FirebaseAuth.instance.currentUser;
  String productName = "";
  int sellingPrice = 0;
  int costPrice = 0;
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
              appbarTitle: "My Wishlist",
              showShoppingCart: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: FutureBuilder(
                future: services.wishlists
                    .doc(user?.uid)
                    .collection('favourite')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: spinkit,
                    );
                  }
                  if (snapshot.data?.docs.length == 0) {
                    return const Center(
                      child: Text("No wishlisted products",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 100,
                            child: Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 70,
                                    width: 90,
                                    child: Image.asset(
                                      "assets/choose_image.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data?.docs[index]
                                              ['productName'],
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
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
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        services.deleteWishlistedProduct(
                                            snapshot.data?.docs[index]['sku']);
                                        setState(() {});
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.grey,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
