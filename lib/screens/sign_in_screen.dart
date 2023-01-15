import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:humari_dukan/screens/home_screen.dart';
import 'package:humari_dukan/screens/sign_up_screen.dart';
import 'package:humari_dukan/services/firebase_services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final bool _rememberMeFlag = false;
  FirebaseServices services = FirebaseServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    "Sign In",
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
                    height: 500,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  visualDensity: const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: _rememberMeFlag,
                                  onChanged: (value) {
                                    setState(() {
                                      value != value;
                                    });
                                  },
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text("Remember Password"),
                                )
                              ],
                            ),
                            const Text("Forget Password?"),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              services
                                  .signInWithEmailAndPassword(
                                      emailController.text.trim(),
                                      passwordController.text.trim())
                                  .then((value) => {
                                        if (value != null)
                                          {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen()))
                                          }
                                        else
                                          {print("Error Occurred")}
                                      });
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
                                "Sign In",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Spacer(),
                        Center(
                          child: Row(
                            children: [
                              const Spacer(),
                              const Spacer(),
                              const Text(
                                "Don't have Account?",
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
                                              const SignUpScreen()));
                                },
                                child: const Text(
                                  "Create Account",
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
