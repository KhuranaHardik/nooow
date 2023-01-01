import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class OffersList extends StatefulWidget {
  const OffersList({super.key});

  @override
  State<OffersList> createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 21),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 17,
        mainAxisSpacing: 17,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromRGBO(210, 210, 210, 1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image
              Container(
                height: 89,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Image.asset(
                  AppAssetImages.banner,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 6),
              // Details
              Padding(
                padding: const EdgeInsets.only(left: 9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.only(right: 31),
                      child: Text(
                        "Order pizzas now & win amazing prizes",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: AppColors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    SizedBox(
                      height: 22,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              print("Show details");
                            },
                            child: Container(
                              // width: 109,
                              // height: 22,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.5, horizontal: 26.5),
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
                              // height: 22,
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
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
