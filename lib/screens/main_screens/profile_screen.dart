import 'package:flutter/material.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/auth/screens/signin_screen.dart';
import 'package:fruitshub/screens/sub_screens/Addresses_screen.dart';
import 'package:fruitshub/screens/sub_screens/favourite_screen.dart';
import 'package:fruitshub/screens/sub_screens/my_orders.dart';
import 'package:fruitshub/screens/sub_screens/personal_profile.dart';
import 'package:fruitshub/widgets/profile_option.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'روبي'; // Sample Arabic name for demonstration
  String email = 'robi123@gmail.com';

  @override
  void initState() {
    getUserName();
    super.initState();
  }

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
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
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
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
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
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: screenWidth * 0.12,
                          backgroundImage:
                              const AssetImage('assets/images/avatar.jpg'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ProfileOption(
                    iconPath: 'assets/profile/user.svg',
                    label: 'الملف الشخصي',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonalProfile(),
                        ),
                      );
                    },
                  ),
                  ProfileOption(
                    iconPath: 'assets/profile/box.svg',
                    label: 'العناوين',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressesScreen(),
                        ),
                      );
                    },
                  ),
                  ProfileOption(
                    iconPath: 'assets/profile/box.svg',
                    label: 'طلباتي',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyOrdersScreen(),
                        ),
                      );
                    },
                  ),
                  ProfileOption(
                    iconPath: 'assets/profile/heart.svg',
                    label: 'المفضلة',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavouriteScreen(),
                        ),
                      );
                    },
                  ),
                  ProfileOption(
                    iconPath: 'assets/profile/notification.svg',
                    label: 'الاشعارات',
                    onTap: () {
                      showTopSnackBar(
                        Overlay.of(context),
                        displayDuration: const Duration(milliseconds: 10),
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
                  ProfileOption(
                    iconPath: 'assets/profile/global.svg',
                    label: 'اللغة',
                    onTap: () {},
                  ),
                  ProfileOption(
                    iconPath: 'assets/profile/magicpen.svg',
                    label: 'الوضع',
                    onTap: () {},
                  ),
                  ProfileOption(
                    iconPath: 'assets/profile/logout.svg',
                    label: 'تسجيل الخروج',
                    onTap: () {
                      _confirmLogout(context);
                    },
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
