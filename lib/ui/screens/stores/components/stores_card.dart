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
      width: width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(210, 210, 210, 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 93,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: AssetImage(AppAssetImages.banner2),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Details
          Text(
            "Comapany Name",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 15,
                // width: 52,
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: AppColors.white,
                  border: Border.all(
                    color: const Color.fromRGBO(186, 186, 186, 1),
                  ),
                ),
                child: Center(
                  child: Text(
                    "4 Offers",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: AppColors.black.withOpacity(0.75),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: 15,
                // width: 52,
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: AppColors.white,
                  border: Border.all(
                    color: const Color.fromRGBO(186, 186, 186, 1),
                  ),
                ),
                child: Center(
                  child: Text(
                    "5 Flyers",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: AppColors.black.withOpacity(0.75),
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
