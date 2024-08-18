import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruitshub/screens/signin_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.52,
                        width: double.infinity,
                        child: SvgPicture.asset(
                          "assets/app/splash1back.svg",
                          color: const Color.fromARGB(255, 255, 220, 151),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: SvgPicture.asset(
                          "assets/app/splash1image.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.52,
                              width: double.infinity,
                              child: SvgPicture.asset(
                                "assets/app/splash2back.svg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: SvgPicture.asset(
                                "assets/app/splash2image.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color(0xff1B5E37),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'ابدء الان',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
