import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_colors.dart';

class HotDealsCategoryWidget extends StatelessWidget {
  final bool isSelected;
  final String categoryImage;
  final String categoryName;
  // final Function()? onTap;
  const HotDealsCategoryWidget({
    super.key,
    required this.isSelected,
    required this.categoryImage,
    required this.categoryName,
    // required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // isSelected = onTap as bool;

    return Column(
      children: [
        Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? AppColors.navyBlue
                : AppColors.navyBlue.withOpacity(0.15),
          ),
          child: Center(
            child: Image.asset(
              categoryImage,
              color: isSelected ? AppColors.white : AppColors.navyBlue,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          categoryName,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
