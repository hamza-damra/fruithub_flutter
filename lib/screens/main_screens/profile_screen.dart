import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/auth/screens/signin_screen.dart';
import 'package:fruitshub/screens/sub_screens/favourite_screen.dart'; // Make sure this import is included
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
          content: const Text(
            '!هل أنت متأكد أنك تريد تسجيل الخروج ؟',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
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
                  color: Colors.redAccent,
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
                  color: Colors.green,
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 60), // Smaller space at the top
            // Profile Avatar and Info (Smaller Header)
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.12, // Reduced avatar size
                    backgroundImage: const AssetImage('assets/images/avatar.jpg'), // Replace with your image asset
                  ),
                  const SizedBox(height: 10), // Smaller space between avatar and name
                  // Name and Email (Smaller Font Sizes)
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18, // Slightly smaller font size for name
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4), // Smaller space between name and email
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 13, // Slightly smaller font size for email
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30), // Smaller space below the header
            // Profile Options List
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(
                    iconPath: 'assets/profile/user.svg',
                    label: 'الملف الشخصي',
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    iconPath: 'assets/profile/box.svg',
                    label: 'طلباتي',
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    iconPath: 'assets/profile/heart.svg',
                    label: 'المفضلة',
                    // Navigate to FavouriteScreen when this option is tapped
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavouriteScreen(),
                        ),
                      );
                    },
                  ),
                  _buildProfileOption(
                    iconPath: 'assets/profile/notification.svg',
                    label: 'الاشعارات',
                    onTap: () {
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
                  _buildProfileOption(
                    iconPath: 'assets/profile/global.svg',
                    label: 'اللغة',
                    onTap: () {},
                  ),
                  _buildProfileOption(
                    iconPath: 'assets/profile/magicpen.svg',
                    label: 'الوضع',
                    onTap: () {},
                  ),
                  _buildProfileOption(
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

  // Profile Option Widget with Icon (Smaller Header Adjustment)
  Widget _buildProfileOption({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: const Icon(
          Icons.arrow_back_ios_new, // Updated modern arrow icon
          color: Colors.grey,
          size: 20,
        ),
        trailing: CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xffF2F3F2),
          child: SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            color: const Color(0xff53B175),
          ),
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.right, // Ensure RTL alignment
        ),
        onTap: onTap,
      ),
    );
  }
}
