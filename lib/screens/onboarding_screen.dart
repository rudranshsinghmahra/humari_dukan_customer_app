import 'package:flutter/material.dart';
import 'package:humari_dukan/screens/sign_in_screen.dart';
import 'package:humari_dukan/screens/sign_up_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffff4a85),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(
                "assets/shopping_cart.png",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "The store of your\ndreams.You will find\nhere what you need",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              },
              child: Container(
                height: 80,
                width: 270,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "Start Shopping",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffff4a85),
                        fontSize: 30),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Don't have a account?",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: const Text(
                "Create Account",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
