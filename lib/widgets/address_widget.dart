import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:humari_dukan/services/firebase_services.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({Key? key}) : super(key: key);

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget>
    with TickerProviderStateMixin {
  FirebaseServices services = FirebaseServices();
  User? user = FirebaseAuth.instance.currentUser;
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
    return StreamBuilder<QuerySnapshot>(
      stream: services.address.doc(user?.uid).collection("Home").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return spinkit;
        }
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${snapshot.data?.docs[0]['recipientName']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "${snapshot.data?.docs[0]['houseNumber']}, "
                      "${snapshot.data?.docs[0]['locality']}, "
                      "${snapshot.data?.docs[0]['city']}, "
                      "${snapshot.data?.docs[0]['state']}, "
                      "${snapshot.data?.docs[0]['pinCode']}, "
                      "${snapshot.data?.docs[0]['country']} ",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
