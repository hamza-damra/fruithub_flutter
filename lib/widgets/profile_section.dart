import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.onPressed,
    required this.section,
    required this.icon,
  });

  final Function() onPressed;
  final String section;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Sharp corners
              ),
            ),
            shadowColor: WidgetStateProperty.all(Colors.transparent),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
                height: MediaQuery.of(context).size.width * 0.07,
                child: SvgPicture.asset(
                  'assets/profile/arrow-right.svg',
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                children: [
                  Text(
                    section,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.040,
                      color: const Color(0xff949D9E),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.07,
                    child: SvgPicture.asset(
                      icon,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width * .90,
          height: 1,
          color: Colors.grey[300],
        )
      ],
    );
  }
}
