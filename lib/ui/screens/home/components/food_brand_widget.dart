import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_strings.dart';

class FoodBrandWidget extends StatelessWidget {
  final String? image;
  final String? offerPercentage;
  final bool isdarkMode;

  final double width;
  const FoodBrandWidget({
    Key? key,
    required this.width,
    this.image,
    this.offerPercentage,
    required this.isdarkMode,
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
            // TODO:Colour change hoga is darkmode ke basis pr
            border: Border.all(color: AppColors.lightGrey),
            image: DecorationImage(
              image: (image == null || image!.isEmpty)
                  ? const AssetImage(AppAssetImages.fashion) as ImageProvider
                  : NetworkImage(image!),
            ),
          ),
        ),
        Container(
          height: 30,
          width: width - 20,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.navyBlue,
          ),
          child: Center(
            child: Text(
              AppString.save10Percent,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 12,
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
