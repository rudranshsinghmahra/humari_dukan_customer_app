import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:humari_dukan/screens/home_screen.dart';
import 'package:humari_dukan/screens/sign_in_screen.dart';
import 'package:humari_dukan/services/firebase_services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final bool _rememberMeFlag = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FirebaseServices services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Theme.of(context).primaryColor),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xffff4a85),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(
                      30,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 160, left: 30, right: 30),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 600,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const GradientBoxBorder(
                              width: 3,
                              gradient: LinearGradient(
                                colors: [Color(0xffff4a85), Colors.yellow],
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: nameController,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const GradientBoxBorder(
                              width: 3,
                              gradient: LinearGradient(
                                colors: [Color(0xffff4a85), Colors.yellow],
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: "Phone Number",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const GradientBoxBorder(
                              width: 3,
                              gradient: LinearGradient(
                                colors: [Color(0xffff4a85), Colors.yellow],
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: emailController,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: "E-mail",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const GradientBoxBorder(
                              width: 3,
                              gradient: LinearGradient(
                                colors: [Color(0xffff4a85), Colors.yellow],
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const GradientBoxBorder(
                              width: 3,
                              gradient: LinearGradient(
                                colors: [Color(0xffff4a85), Colors.yellow],
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (emailController.text.isNotEmpty &&
                                nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty &&
                                phoneController.text.length == 10 &&
                                passwordController.text.length >= 6 &&
                                passwordController.text.length >= 6) {
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                services
                                    .createUserWithEmailAndPassword(
                                        emailController.text.trim(),
                                        passwordController.text.trim())
                                    .then(
                                      (value) => {
                                        if (value != null)
                                          {
                                            services
                                                .saveUserDetailsToDatabase(
                                                    value.user?.uid,
                                                    emailController.text,
                                                    passwordController.text,
                                                    nameController.text,
                                                    phoneController.text)
                                                .then(
                                                  (value) => {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeScreen(),
                                                      ),
                                                    ),
                                                  },
                                                )
                                          }
                                        else
                                          {
                                            print("Error Occurred"),
                                          }
                                      },
                                    );
                              } else {
                                print("Password Mismatch");
                              }
                            } else {
                              print("Enter valid details");
                            }
                          },
                          child: Container(
                            height: 70,
                            width: 180,
                            decoration: BoxDecoration(
                              color: const Color(0xffff4a85),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Row(
                            children: [
                              const Spacer(),
                              const Spacer(),
                              const Text(
                                "Already have Account?",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInScreen()));
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffff4a85),
                                      fontSize: 18),
                                ),
                              ),
                              const Spacer(),
                              const Spacer(),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
