import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/auth/screens/change_email.dart';
import 'package:fruitshub/auth/screens/reset_password.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  late String email = '';
  late String name = '';
  void getUserData() async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(
      await SharedPrefManager().getData('token'),
    );

    if (kDebugMode) {
      print(decodedToken);
    }

    setState(() {
      email = decodedToken['sub'];
      name = decodedToken['name'];
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'الملف الشخصي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset(
                    'assets/images/avatar.jpg',
                    width: screenWidth * 0.30,
                    height: screenWidth * 0.30,
                  ),
                ),
                // Positioned(
                //   top: screenWidth * 0.24,
                //   right: 1,
                //   left: 1,
                //   child: IconButton(
                //     icon: SvgPicture.asset(
                //       'assets/profile/change-image.svg',
                //       width: screenWidth * 0.08,
                //       height: screenWidth * 0.08,
                //     ),
                //     onPressed: () {},
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045,
              ),
            ),
            Text(
              email,
              style: TextStyle(
                color: const Color(0xff888FA0),
                fontSize: screenWidth * 0.037,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.96,
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );

                  http.Response verificationResponse =
                      await ManageUsers().sendResetEmailOtpMessage(
                    email: email,
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);

                  if (verificationResponse.statusCode == 200 ||
                      verificationResponse.statusCode == 201) {
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeEmail(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E37),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.solidEnvelope,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Text(
                      'تغيير البريد الالكتروني',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.96,
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );

                  http.Response verificationResponse =
                      await ManageUsers().sendResetPasswordEmail(
                    email,
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);

                  if (verificationResponse.statusCode == 200 ||
                      verificationResponse.statusCode == 201) {
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPassword(
                          screen: 'reset',
                          email: email,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E37),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.lock,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Text(
                      'تغيير كلمه المرور',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
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
