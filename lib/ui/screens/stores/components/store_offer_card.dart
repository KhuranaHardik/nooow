// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class StoreOffersCard extends StatelessWidget {
  final double height;
  Function()? seeDetailsOnTap;
  Function()? saveOnTap;
  final bool isDarkMode;
  StoreOffersCard({
    super.key,
    required this.height,
    this.seeDetailsOnTap,
    this.saveOnTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image
        Container(
          height: height * 0.125,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            image: DecorationImage(
              image: AssetImage(AppAssetImages.banner),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Details
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Christmas Offer",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  // TODO:Colour change hoga is darkmode ke basis pr
                  color: AppColors.black,
                ),
              ),
              Text(
                "Upto 50% Off",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "Order pizzas now & win amazing prizes",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: AppColors.black.withOpacity(0.75),
                ),
              ),
              const SizedBox(height: 11),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: saveOnTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 4.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.navyBlue,
                        border: Border.all(
                          color: const Color.fromRGBO(210, 210, 210, 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // const SizedBox(width: 6),
                  InkWell(
                    onTap: seeDetailsOnTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 4.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: const Color.fromRGBO(244, 205, 69, 1),
                      ),
                      child: Center(
                        child: Text(
                          "See Details",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 9)
      ],
    );
  }
}
