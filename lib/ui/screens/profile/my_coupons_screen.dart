import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/theme_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:provider/provider.dart';

class MyCouponsScreen extends StatefulWidget {
  const MyCouponsScreen({super.key});

  @override
  State<MyCouponsScreen> createState() => _MyCouponsScreenState();
}

class _MyCouponsScreenState extends State<MyCouponsScreen> {
  bool get isSignIn => (AppSharedPrefrence().userData == null ||
          AppSharedPrefrence().userData!.isEmpty)
      ? false
      : true;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            // TODO:Colour change hoga is darkmode ke basis pr
            backgroundColor: AppColors.navyBlue,
            elevation: 0.0,
            title: Text(
              'My Coupons',
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
              const SizedBox(width: 10)
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
            children: [
              Container(
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromRGBO(219, 219, 219, 1)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Offers & Coupons',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 13.0),
                          child: DottedBorder(
                            dashPattern: const [5, 5],
                            radius: const Radius.circular(7),
                            color: const Color.fromRGBO(210, 210, 210, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 15),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Christmas Coupon offer',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Coupon Code : MTK1278',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color:
                                            AppColors.black.withOpacity(0.75),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
