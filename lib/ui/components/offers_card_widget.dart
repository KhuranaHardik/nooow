import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class OffersCardWidget extends StatelessWidget {
  final String offerName;
  final String offerDiscount;
  final String offerDescreption;
  const OffersCardWidget({
    super.key,
    required this.offerName,
    required this.offerDiscount,
    required this.offerDescreption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 205,
      padding: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: const Color.fromRGBO(210, 210, 210, 1),
        border: Border.all(
          color: const Color.fromRGBO(210, 210, 210, 1),
        ),
      ),
      child: Column(
        children: [
          // Image
          Container(
            // height: 84,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offerName,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  offerDiscount,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Padding(
                  padding: const EdgeInsets.only(right: 44),
                  child: Text(
                    offerDescreption,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: AppColors.black.withOpacity(0.75),
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        print("Show details");
                      },
                      child: Container(
                        width: 109,
                        height: 22,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.5,
                          // horizontal: 26.5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: AppColors.navyBlue,
                          border: Border.all(
                            color: const Color.fromRGBO(210, 210, 210, 1),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "See Details",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        print("Delete Item");
                      },
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: const Color.fromRGBO(255, 76, 46, 1),
                        ),
                        child: Center(
                          child: Image.asset(
                            AppAssetImages.delete,
                            width: 10.5,
                            height: 13.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
