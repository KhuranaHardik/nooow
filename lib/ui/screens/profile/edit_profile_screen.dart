import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/components/drawer.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameTextController;
  late FocusNode _nameFocusNode;
  late TextEditingController _mobileTextController;
  late FocusNode _mobileFocusNode;
  late TextEditingController _emailTextController;
  late FocusNode _emailFocusNode;
  late TextEditingController _locationTextController;
  late FocusNode _locationFocusNode;
  bool get isSignIn => (AppSharedPrefrence().userData == null ||
          AppSharedPrefrence().userData!.isEmpty)
      ? false
      : true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: AppDrawer(
        isUserSignedIn: isSignIn,
        backgroundHeight: size.height * 0.18,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
        actions: [
          // Favorites
          InkWell(
            radius: 10,
            onTap: () {
              !isSignIn
                  ? Navigator.pushNamed(context, AppRoutes.signInScreen)
                  : Navigator.pushNamed(context, AppRoutes.myListScreen);
            },
            child: SizedBox(
              width: 26,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 17, right: 6),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    // right: 2,
                    left: 12,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.red,
                      child: Center(
                        child: Text(
                          '0',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Notifications
          InkWell(
            onTap: () {
              !isSignIn
                  ? Navigator.pushNamed(context, AppRoutes.signInScreen)
                  : log('Notifications');
            },
            child: SizedBox(
              width: 26,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 17, right: 6),
                    child: Icon(
                      Icons.notifications_none,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.red,
                      child: Center(
                        child: Text(
                          '0',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 2)
        ],
      ),
    );
  }
}
