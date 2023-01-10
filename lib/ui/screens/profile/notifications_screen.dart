import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/screens/profile/components/notification_tile.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool get isSignIn => (AppSharedPrefrence().userData == null ||
          AppSharedPrefrence().userData!.isEmpty)
      ? false
      : true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'Notifications',
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
          const SizedBox(width: 10)
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: const [NotificationTileWidget()],
      ),
    );
  }
}
