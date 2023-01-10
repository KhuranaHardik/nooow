import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class StoresCard extends StatelessWidget {
  final String? image;
  final String? companyName;
  final String? flyers;
  final String? offers;
  final double width;
  const StoresCard({
    super.key,
    required this.width,
    this.image,
    this.companyName,
    this.flyers,
    this.offers,
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
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: (image == null || image!.isEmpty)
                    ? const AssetImage(AppAssetImages.banner2) as ImageProvider
                    : NetworkImage(image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Details
          Text(
            companyName ?? '',
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
                    "$offers Offers",
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
                    "$flyers Flyers",
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
