import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:humari_dukan/widgets/bottom_nav_bar.dart';
import 'package:humari_dukan/widgets/custom_appbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const CustomAppBar(appbarTitle: "Settings"),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 70.0, left: 10, right: 10, bottom: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 390,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customCardForSetting(
                                  "Product Updates",
                                  "Stair lifts from the freedom of your home",
                                  true),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              customCardForSetting(
                                  "Comments",
                                  "Stair lifts from the freedom of your home",
                                  false),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              customCardForSetting("Offer Updates",
                                  "A right media mix can make", true),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              customCardForSetting("Notifications",
                                  "Creating remarkable power prints", false),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffff4a85),
                          borderRadius: BorderRadius.circular(10)),
                      width: 300,
                      height: 80,
                      child: const Center(
                        child: Text(
                          "Update Settings",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget customCardForSetting(
      String title, String description, bool switchValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FlutterSwitch(
              width: 70,
              height: 30,
              activeColor: const Color(0xffff4a85),
              value: switchValue,
              onToggle: (val) {
                setState(() {});
              },
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Text(
            description,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
