import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:humari_dukan/widgets/custom_appbar.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  FirebaseServices firebaseServices = FirebaseServices();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String userName = "";
  String phoneNumber = "";
  String email = "";

  Future<UserData> getUserData() async {
    final DocumentSnapshot snapshot =
        await firebaseServices.users.doc(firebaseServices.user?.uid).get();
    final userName = snapshot['name'];
    final phoneNumber = snapshot['phoneNumber'];
    final email = snapshot['email'];

    return UserData(username: userName, phoneNumber: phoneNumber, email: email);
  }

  @override
  void initState() {
    getUserData().then((details) => {
          nameController.text = details.username,
          emailController.text = details.email,
          phoneController.text = details.phoneNumber
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const CustomAppBar(
              appbarTitle: "Account Details",
              showShoppingCart: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            color: const Color(0xffff4a85),
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset("assets/choose_image.png"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0, left: 25, right: 25),
                      child: Text(
                        "Your Information",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 25, right: 25),
                      child: Divider(
                        color: Colors.grey,
                        height: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: "Name",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffff4a85))),
                                    labelStyle:
                                        TextStyle(color: Color(0xffff4a85)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffff4a85),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: phoneController,
                                    decoration: const InputDecoration(
                                      labelText: "Phone",
                                      labelStyle:
                                          TextStyle(color: Color(0xffff4a85)),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffff4a85)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xffff4a85),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      labelText: "Email",
                                      labelStyle:
                                          TextStyle(color: Color(0xffff4a85)),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffff4a85)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xffff4a85),
                                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class UserData {
  final String username;
  final String phoneNumber;
  final String email;

  UserData(
      {required this.username, required this.phoneNumber, required this.email});
}
