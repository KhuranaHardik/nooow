// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/components/user_not_found_error.dart';
import 'package:nooow/ui/screens/profile/components/tile_card.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:nooow/utils/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({super.key});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool get isSignIn => (AppSharedPrefrence().userData == null ||
          AppSharedPrefrence().userData!.isEmpty)
      ? false
      : true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'Settings',
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
                  : Navigator.pushNamed(context, AppRoutes.notificationScreen);
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
          const SizedBox(width: 10)
        ],
      ),
      body: Consumer2<UIProvider, ApiServiceProvider>(
        builder: (context, uiProvider, apiServiceProvider, child) {
          return (isSignIn == false)
              ? const UserNotFoundErrorWidget()
              : Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 23,
                      ),
                      children: [
                        TileCardWidget(
                          isThemeButton: false,
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.editProfileScreen);
                          },
                          name: "Profile",
                          icon: AppAssetImages.profile,
                          isLogOutButton: false,
                        ),
                        const SizedBox(height: 5),
                        TileCardWidget(
                          isThemeButton: false,
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.notificationScreen);
                          },
                          name: "Notifications",
                          icon: AppAssetImages.notification,
                          isLogOutButton: false,
                        ),
                        // const SizedBox(height: 5),
                        // TileCardWidget(
                        //   isThemeButton: false,
                        //   onTap: () {
                        //     Navigator.pushNamed(
                        //         context, AppRoutes.myCouponsScreen);
                        //   },
                        //   name: "Intrest",
                        //   icon: AppAssetImages.mostPopular,
                        //   isLogOutButton: false,
                        // ),
                        const SizedBox(height: 5),
                        TileCardWidget(
                          isThemeButton: true,
                          onTap: () {},
                          name: "Dark Mode",
                          icon: AppAssetImages.profile,
                          isLogOutButton: false,
                        ),
                        const SizedBox(height: 5),
                        TileCardWidget(
                          isThemeButton: false,
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      const Text(AppString.areYouSureToLogout),
                                  actions: [
                                    IconButton(
                                      onPressed: () async {
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
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
                          name: "Logout",
                          icon: AppAssetImages.drawerLogOut,
                          isLogOutButton: true,
                        ),
                      ],
                    ),
                    // Loading Screen
                    uiProvider.loading
                        ? Container(
                            height: size.height,
                            color: AppColors.whiteBackground.withOpacity(0.4),
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.navyBlue),
                            ),
                          )
                        : const SizedBox()
                  ],
                );
        },
      ),
    );
  }
}
