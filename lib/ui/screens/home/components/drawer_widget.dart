import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/ui/screens/home/components/drawer_list_tile.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawer({
  required BuildContext context,
  required bool? isUserSignedIn,
  required double backgroungHeight,
}) {
  bool signedIn = isUserSignedIn ?? false;
  return Drawer(
    elevation: 0.0,
    child: ListView(
      children: [
        Container(
          height: backgroungHeight,
          padding: const EdgeInsets.only(top: 36, bottom: 30, left: 22),
          decoration: const BoxDecoration(
            color: AppColors.navyBlue,
            borderRadius: BorderRadius.only(topRight: Radius.circular(8.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(radius: 24),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    signedIn ? 'User Name' : 'Login/Signup',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                  // Text(
                  //   'Farmer',
                  //   style: GoogleFonts.poppins(
                  //     fontWeight: FontWeight.w400,
                  //     color: AppColors.white,
                  //     fontSize: 14,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 17.5, right: 17.5, top: 24),
          child: Column(
            children: [
              // Settings
              DrawerListTile(
                iconPath: AppAssetImages.settings,
                tileTitle: "Settings",
                isDropDown: true,
                onTap: () {},
              ),
              const SizedBox(height: 11),
              // Privacy & Policy
              DrawerListTile(
                iconPath: AppAssetImages.drawerPrivacyPolicy,
                tileTitle: "Privacy & Policy",
                isDropDown: false,
                onTap: () {},
              ),
              const SizedBox(height: 11),
              // Refer To Friends
              DrawerListTile(
                iconPath: AppAssetImages.share,
                tileTitle: "Refer To Friends",
                isDropDown: false,
                onTap: () {},
              ),
              const SizedBox(height: 11),
              // Logout
              signedIn
                  ? DrawerListTile(
                      iconPath: AppAssetImages.drawerLogOut,
                      tileTitle: "Logout",
                      isDropDown: false,
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Are you sure to logout?'),
                              actions: [
                                IconButton(
                                  onPressed: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    if (await pref.clear()) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.signInScreen,
                                          (route) => false);
                                    }
                                  },
                                  icon: const Text('Yes'),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )
                  : DrawerListTile(
                      iconPath: AppAssetImages.profile,
                      tileTitle: 'Login / Register',
                      isDropDown: false,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.signInScreen,
                        );
                      },
                    ),
            ],
          ),
        ),
      ],
    ),
  );
}
