// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/ui/screens/home/components/drawer_list_tile.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:nooow/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  final bool isUserSignedIn;
  final double backgroundHeight;
  const AppDrawer(
      {super.key, this.isUserSignedIn = false, required this.backgroundHeight});

  @override
  Widget build(BuildContext context) {
    print(isUserSignedIn);
    return Drawer(
      elevation: 0.0,
      child: ListView(
        children: [
          isUserSignedIn
              ? Container(
                  height: backgroundHeight,
                  padding: const EdgeInsets.only(top: 36, bottom: 30, left: 22),
                  decoration: const BoxDecoration(
                    color: AppColors.navyBlue,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(8.0)),
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
                            isUserSignedIn
                                ? AppSharedPrefrence().userData![1]
                                : AppString.signInSignUp,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(left: 17.5, right: 17.5, top: 24),
            child: Column(
              children: [
                isUserSignedIn
                    ? Column(
                        children: [
                          // Profile
                          DrawerListTile(
                            iconPath: AppAssetImages.profile,
                            tileTitle: 'Profile',
                            isLogoutButton: false,
                            onTap: () {},
                          ),
                          const SizedBox(height: 11),
                          // // Coupons
                          // DrawerListTile(
                          //   isLogoutButton: false,
                          //   iconPath: AppAssetImages.mostPopular,
                          //   tileTitle: 'Coupons',
                          //   onTap: () {},
                          // ),
                          // const SizedBox(height: 11),
                          // Favorites
                          DrawerListTile(
                            isLogoutButton: false,
                            iconPath: AppAssetImages.settings,
                            tileTitle: 'Favourite',
                            onTap: () {},
                          ),
                          const SizedBox(height: 11),
                          // Intrests
                          DrawerListTile(
                            isLogoutButton: false,
                            iconPath: AppAssetImages.intrests,
                            tileTitle: 'Intrests',
                            onTap: () {},
                          ),
                          const SizedBox(height: 11),
                          // All Categories
                          DrawerListTile(
                            isLogoutButton: false,
                            iconPath: AppAssetImages.settings,
                            tileTitle: 'All Categories',
                            onTap: () {},
                          ),
                          const SizedBox(height: 11),
                          // Privacy & Policy
                          DrawerListTile(
                            isLogoutButton: false,
                            iconPath: AppAssetImages.drawerPrivacyPolicy,
                            tileTitle: AppString.privacyAndPolicy,
                            onTap: () {},
                          ),
                          const SizedBox(height: 11),
                          // FAQ
                          DrawerListTile(
                            isLogoutButton: false,
                            iconPath: AppAssetImages.drawerPrivacyPolicy,
                            tileTitle: 'FAQ',
                            onTap: () {},
                          ),
                          const SizedBox(height: 11),
                          // Refer To Friends
                          DrawerListTile(
                            isLogoutButton: false,
                            iconPath: AppAssetImages.share,
                            tileTitle: AppString.referToFriends,
                            onTap: () {},
                          ),
                          const SizedBox(height: 11),
                          // Drawer
                          DrawerListTile(
                            isLogoutButton: false,
                            isDarkmode: true,
                            iconPath: AppAssetImages.share,
                            tileTitle: 'Dark Mode',
                            onTap: () {},
                          ),
                          const SizedBox(height: 11),
                        ],
                      )
                    : const SizedBox.shrink(),
                // Logout
                isUserSignedIn
                    ? DrawerListTile(
                        isLogoutButton: true,
                        iconPath: AppAssetImages.drawerLogOut,
                        tileTitle: AppString.logout,
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(AppString.areYouSureToLogout),
                                actions: [
                                  IconButton(
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      if (await pref.clear()) {
                                        await AppSharedPrefrence()
                                            .setUserSignedIn(false);
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            AppRoutes.signInScreen,
                                            (route) => false);
                                      }
                                    },
                                    icon: const Text(AppString.yes),
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Text(AppString.no),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    : CustomElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, AppRoutes.signInScreen);
                        },
                        buttonColor: AppColors.navyBlue,
                        borderColor: AppColors.navyBlue,
                        child: const Text(AppString.signInSignUp),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
