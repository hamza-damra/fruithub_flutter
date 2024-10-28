import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileOption extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 9,
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
            // ignore: deprecated_member_use
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
