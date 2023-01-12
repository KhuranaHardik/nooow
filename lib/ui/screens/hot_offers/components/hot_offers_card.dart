// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_strings.dart';

class HotDealsOfferCard extends StatelessWidget {
  String offerName;
  String discount;
  String offerDescription;
  final double height;
  Function()? seeDetailsOnTap;
  Function()? saveOnTap;
  bool isDarkMode;

  HotDealsOfferCard({
    super.key,
    required this.offerName,
    required this.discount,
    required this.offerDescription,
    required this.height,
    this.seeDetailsOnTap,
    this.saveOnTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image
        Align(
          alignment: Alignment.topCenter,
          child: Container(
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
        ),
        const SizedBox(height: 4),
        // Details
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offerName,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  // TODO:Colour change hoga is darkmode ke basis pr
                  color: AppColors.black,
                ),
              ),
              Text(
                discount,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                offerDescription,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: AppColors.black.withOpacity(0.75),
                ),
              ),
              const SizedBox(height: 11),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          AppString.save,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: seeDetailsOnTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 4.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: const Color.fromRGBO(244, 205, 69, 1),
                      ),
                      child: Center(
                        child: Text(
                          AppString.seeDetails,
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
