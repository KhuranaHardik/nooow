import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:nooow/utils/app_strings.dart';

class UserNotFoundErrorWidget extends StatelessWidget {
  const UserNotFoundErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AppAssetImages.userNotFound),
        const SizedBox(height: 20),
        Text(
          'User Not Found',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: AppColors.navyBlue,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomElevatedButton(
            buttonColor: AppColors.navyBlue,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.signInScreen);
            },
            borderColor: AppColors.navyBlue,
            child: const Text(AppString.signInSignUp),
          ),
        ),
      ],
    );
  }
}
