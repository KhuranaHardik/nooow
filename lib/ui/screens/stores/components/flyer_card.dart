import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class FlyersCard extends StatelessWidget {
  final double height;
  final bool isDarkMode;
  const FlyersCard({
    super.key,
    required this.height,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        Container(
          height: height,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            image: DecorationImage(
              image: AssetImage(AppAssetImages.banner3),
              fit: BoxFit.fill,
            ),
          ),
        ),
        // const SizedBox(height: 16),
        // Details
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Great Indian Festival",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              // TODO:Colour change hoga is darkmode ke basis pr
              color: AppColors.black,
            ),
          ),
        ),
        // const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 17.0),
          child: Text(
            "Order pizzas now & win amazing prizes",
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: AppColors.black.withOpacity(0.75),
            ),
          ),
        ),
      ],
    );
  }
}
