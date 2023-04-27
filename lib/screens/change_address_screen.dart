import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:humari_dukan/screens/add_address_screen.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:humari_dukan/widgets/custom_appbar.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({Key? key}) : super(key: key);

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  FirebaseServices services = FirebaseServices();
  User? user = FirebaseAuth.instance.currentUser;
  String addressType = "Home";
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController country = TextEditingController();

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
                appbarTitle: "Change Address", showShoppingCart: false),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                children: [
                  Container(
                    color: Colors.grey.shade200,
                    child: Row(
                      children: [
                        Checkbox(
                          value: addressType == 'Home',
                          onChanged: (newValue) {
                            setState(() {
                              addressType = (newValue! ? 'Home' : null)!;
                            });
                          },
                        ),
                        const Text('Home'),
                        Checkbox(
                          value: addressType == 'Office',
                          onChanged: (newValue) {
                            setState(() {
                              addressType = (newValue! ? 'Office' : null)!;
                            });
                          },
                        ),
                        const Text('Office'),
                        Checkbox(
                          value: addressType == 'Other',
                          onChanged: (newValue) {
                            setState(() {
                              addressType = (newValue! ? 'Other' : null)!;
                            });
                          },
                        ),
                        const Text('Other'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: services.address
                            .doc(user?.uid)
                            .collection(addressType)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return spinkit;
                          }
                          return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xffc4c4c4),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Recipient Name",
                                                    style: TextStyle(
                                                      color: Color(0xffff4a85),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 16),
                                                      child: Text(snapshot
                                                              .data?.docs[index]
                                                          ['recipientName'])),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xffc4c4c4),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "House Number",
                                                    style: TextStyle(
                                                      color: Color(0xffff4a85),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 16),
                                                      child: Text(snapshot
                                                              .data?.docs[index]
                                                          ['houseNumber'])),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xffc4c4c4),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomLeft: Radius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              "Locality",
                                              style: TextStyle(
                                                color: Color(0xffff4a85),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 16),
                                              child: Text(
                                                snapshot.data?.docs[index]
                                                    ['locality'],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xffc4c4c4),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "City",
                                                    style: TextStyle(
                                                      color: Color(0xffff4a85),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 16),
                                                      child: Text(snapshot
                                                              .data?.docs[index]
                                                          ['city'])),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xffc4c4c4),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "State",
                                                    style: TextStyle(
                                                      color: Color(0xffff4a85),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 16),
                                                      child: Text(snapshot
                                                              .data?.docs[index]
                                                          ['state'])),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xffc4c4c4),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Pincode",
                                                    style: TextStyle(
                                                      color: Color(0xffff4a85),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 16),
                                                    child: Text(
                                                      snapshot.data?.docs[index]
                                                          ['pinCode'],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xffc4c4c4),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Country",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffff4a85),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 16),
                                                      child: Text(
                                                        snapshot.data
                                                                ?.docs[index]
                                                            ['country'],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xffff4a85,
                                          ),
                                        ),
                                        child: Row(
                                          children: const [
                                            Expanded(
                                                child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Center(
                                                  child: Text(
                                                "Select Address",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            )),
                                          ],
                                        )),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 18.0),
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      bottom: 12,
                      left: 8,
                      right: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff91e0c8),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddAddressScreen(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Text(
                                "Add new address",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
