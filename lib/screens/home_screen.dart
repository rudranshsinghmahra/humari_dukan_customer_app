import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humari_dukan/screens/cart_screen.dart';
import 'package:humari_dukan/screens/product_details_screen.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:humari_dukan/widgets/bottom_nav_bar.dart';
import 'package:humari_dukan/widgets/counter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  String userEmail = "";
  final List<String> items = [
    'Messages',
    'Notification',
    'Accounts Details',
    'My Purchases',
    'Settings',
    ""
  ];

  final List<double>? customItemsHeights = [
    60,
    60,
    60,
    60,
    60,
    30,
  ];
  String? selectedValue;
  bool appBarMenuPressed = false;
  FirebaseServices services = FirebaseServices();
  User? user = FirebaseAuth.instance.currentUser;
  bool productExistInCart = false;

  getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await services.users
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) => {
                userName = documentSnapshot['name'],
                userEmail = documentSnapshot['email'],
              })
          .catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Theme.of(context).primaryColor),
        child: SafeArea(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Stack(
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xffff4a85),
                      // borderRadius: BorderRadius.only(
                      //   bottomRight: appBarMenuPressed
                      //       ? const Radius.circular(0)
                      //       : const Radius.circular(30),
                      //   bottomLeft: appBarMenuPressed
                      //       ? const Radius.circular(0)
                      //       : const Radius.circular(30),
                      // ),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, bottom: 10, top: 5),
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
                                      userName.toString(),
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
                              padding: const EdgeInsets.only(
                                  right: 20.0, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              const CartScreen(),
                                          transitionDuration:
                                              const Duration(seconds: 0)));
                                },
                                child: const Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Center(
                              child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Row(
                                        children: [
                                          item == "Messages"
                                              ? const Icon(
                                                  Icons.message,
                                                  color: Colors.white,
                                                )
                                              : (item == "Notification"
                                                  ? const Icon(
                                                      Icons.notifications,
                                                      color: Colors.white,
                                                    )
                                                  : (item == "Accounts Details"
                                                      ? const Icon(
                                                          Icons
                                                              .account_box_sharp,
                                                          color: Colors.white,
                                                        )
                                                      : item == "My Purchases"
                                                          ? const Icon(
                                                              Icons
                                                                  .shopping_cart,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : (item == "Settings"
                                                              ? const Icon(
                                                                  Icons
                                                                      .settings,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              : Container()))),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            item,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ],
                                      )))
                                  .toList(),
                              value: selectedValue,
                              customItemsHeights: customItemsHeights,
                              dropdownDecoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30)),
                                color: Color(0xffff4a85),
                              ),
                              isExpanded: true,
                              dropdownElevation: 0,
                              iconEnabledColor: const Color(0xffff4a85),
                              iconDisabledColor: const Color(0xffff4a85),
                              dropdownMaxHeight: 350,
                              dropdownWidth: MediaQuery.of(context).size.width,
                              onChanged: (value) {},
                              onMenuStateChange: (isOpen) {
                                if (isOpen) {
                                  appBarMenuPressed = true;
                                } else {
                                  appBarMenuPressed = false;
                                }
                              },
                            ),
                          )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 70,
                      left: 20,
                      right: 20,
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: services.products.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.8, crossAxisCount: 2),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        ProductDetailsScreen(
                                      documentSnapshot:
                                          snapshot.data!.docs[index],
                                    ),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ),
                                );
                              },
                              child: Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, bottom: 8),
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
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4, left: 20, right: 20),
                                        child: CounterWidget(
                                          documentSnapshot:
                                              snapshot.data!.docs[index],
                                        )
                                        // Row(
                                        //   children: [
                                        //     Expanded(
                                        //       child: ElevatedButton(
                                        //         onPressed: () {
                                        //           services
                                        //               .addProductsToCart(
                                        //               user?.uid,
                                        //               snapshot.data
                                        //                   ?.docs[index]
                                        //               ['productName'],
                                        //               snapshot.data
                                        //                   ?.docs[index]
                                        //               ['description'],
                                        //               snapshot.data
                                        //                   ?.docs[index]
                                        //               ['costPrice'],
                                        //               snapshot.data
                                        //                   ?.docs[index]
                                        //               ['sellingPrice'],
                                        //               snapshot.data
                                        //                   ?.docs[index]
                                        //               ['sku'],
                                        //               1)
                                        //               .then(
                                        //                 (value) => {
                                        //               ScaffoldMessenger.of(
                                        //                   context)
                                        //                 ..hideCurrentSnackBar()
                                        //                 ..showSnackBar(
                                        //                     snackBar)
                                        //             },
                                        //           );
                                        //         },
                                        //         style: ElevatedButton.styleFrom(
                                        //             backgroundColor:
                                        //             const Color(0xffffe156)),
                                        //         child: const Text(
                                        //           "Add to Cart",
                                        //           style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
