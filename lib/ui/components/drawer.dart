import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/services/local_db.dart';
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
    return Drawer(
      elevation: 0.0,
      child: ListView(
        children: [
          Container(
            height: backgroundHeight,
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17.5, right: 17.5, top: 24),
            child: Column(
              children: [
                // Settings
                DrawerListTile(
                  iconPath: AppAssetImages.settings,
                  tileTitle: AppString.settings,
                  isDropDown: true,
                  onTap: () {},
                ),
                const SizedBox(height: 11),
                // Privacy & Policy
                DrawerListTile(
                  iconPath: AppAssetImages.drawerPrivacyPolicy,
                  tileTitle: AppString.privacyAndPolicy,
                  isDropDown: false,
                  onTap: () {},
                ),
                const SizedBox(height: 11),
                // Refer To Friends
                DrawerListTile(
                  iconPath: AppAssetImages.share,
                  tileTitle: AppString.referToFriends,
                  isDropDown: false,
                  onTap: () {},
                ),
                const SizedBox(height: 11),
                // Logout
                isUserSignedIn
                    ? DrawerListTile(
                        iconPath: AppAssetImages.drawerLogOut,
                        tileTitle: AppString.logout,
                        isDropDown: false,
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
                    : DrawerListTile(
                        iconPath: AppAssetImages.profile,
                        tileTitle: AppString.signInSignUp,
                        isDropDown: false,
                        onTap: () {
                          Navigator.pop(context);
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
}
