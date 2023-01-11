import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_colors.dart';

class PopularCategoriesScreen extends StatefulWidget {
  const PopularCategoriesScreen({super.key});

  @override
  State<PopularCategoriesScreen> createState() =>
      _PopularCategoriesScreenState();
}

class _PopularCategoriesScreenState extends State<PopularCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.black,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
        ),
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'Popular Categories',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
