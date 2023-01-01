import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class StoresCard extends StatelessWidget {
  final double width;
  const StoresCard({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: width * 0.42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(210, 210, 210, 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 93,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: AssetImage(AppAssetImages.banner),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Details
          Text(
            "Christmas Offer",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 10,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  print("Show details");
                },
                child: Container(
                  // width: 109,
                  height: 22,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.5, horizontal: 15),
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
              const SizedBox(width: 6),
              InkWell(
                onTap: () {
                  print("See details");
                },
                child: Container(
                  // width: 22,
                  height: 22,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.5, horizontal: 11),
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
          // const SizedBox(height: 9)
        ],
      ),
    );
  }
}
