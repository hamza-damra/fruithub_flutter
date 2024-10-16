import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/auth/screens/signin_screen.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/screens/sub_screens/favourite_screen.dart';
import 'package:fruitshub/screens/sub_screens/personal_profile.dart';
import 'package:fruitshub/widgets/profile_section.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String email = '';
  void getUserName() async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(
      await SharedPrefManager().getData('token'),
    );

    setState(() {
      name = decodedToken['name'];
      email = decodedToken['sub'];
    });
  }

  Future<void> _logOut() async {
    await SharedPrefManager().deleteData('token');
    mostSelling.clear();
    mostSelling.clear();
    lastAdded.clear();
    cart.clear();
    favourite.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    // Show a confirmation dialog before logging out
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'تسجيل الخروج',
            textAlign: TextAlign.right,
          ),
          content: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '!هل أنت متأكد أنك تريد تسجيل الخروج ؟',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'إلغاء',
                textAlign: TextAlign.right,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logOut(); // Log out after confirmation
              },
              child: const Text(
                'تأكيد',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'حسابي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(flex: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                ],
              ),
              const Spacer(flex: 2),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset(
                      'assets/images/avatar.jpg',
                      width: screenWidth * 0.18,
                      height: screenWidth * 0.18,
                    ),
                  ),
                  Positioned(
                    top: screenWidth * 0.11,
                    right: screenWidth * 0.02,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/profile/change-image.svg',
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
          const SizedBox(height: 35),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(flex: 30),
              Text(
                'عام',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
          const SizedBox(height: 7),
          ProfileSection(
            icon: 'assets/profile/user.svg',
            section: 'الملف الشخصي',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonalProfile(),
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          ProfileSection(
            icon: 'assets/profile/box.svg',
            section: 'طلباتي',
            onPressed: () {},
          ),
          const SizedBox(height: 5),
          ProfileSection(
            icon: 'assets/profile/heart.svg',
            section: 'المفضلة',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavouriteScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          ProfileSection(
            icon: 'assets/profile/notification.svg',
            section: 'الاشعارات',
            onPressed: () {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.info(
                  message: "سيتم توفير الاشعارات قريبا",
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          ProfileSection(
            icon: 'assets/profile/global.svg',
            section: 'اللغة',
            onPressed: () {},
          ),
          const SizedBox(height: 5),
          ProfileSection(
            icon: 'assets/profile/magicpen.svg',
            section: 'الوضع',
            onPressed: () {},
          ),
          const SizedBox(height: 45),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(
                  Color(0xffEBF9F1),
                ),
                shape: WidgetStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                shadowColor: const WidgetStatePropertyAll(
                  Colors.transparent,
                ),
              ),
              onPressed: () {
                _confirmLogout(context);
              },
              child: Row(
                children: [
                  const Spacer(flex: 1),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.1416), // 180 degrees flip
                    child: Icon(
                      Icons.logout_rounded,
                      color: const Color(0xff53B175),
                      size: MediaQuery.of(context).size.width *
                          0.06, // Responsive icon size
                    ),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      color: const Color(0xff1B5E37),
                      fontSize: MediaQuery.of(context).size.width *
                          0.045, // Responsive text size
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
