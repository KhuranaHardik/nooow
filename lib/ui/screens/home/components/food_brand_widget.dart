import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_strings.dart';

class FoodBrandWidget extends StatelessWidget {
  final double width;
  const FoodBrandWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: width,
          width: width,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            border: Border.all(color: AppColors.lightGrey),
          ),
        ),
        Container(
          height: 30,
          width: width - 10,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.navyBlue,
          ),
          child: Center(
            child: Text(
              AppString.save10Percent,
              style: GoogleFonts.montserrat(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
