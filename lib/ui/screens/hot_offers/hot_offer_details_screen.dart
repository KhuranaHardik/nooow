import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class HotOfferDetailScreen extends StatefulWidget {
  const HotOfferDetailScreen({super.key});

  @override
  State<HotOfferDetailScreen> createState() => _HotOfferDetailScreenState();
}

class _HotOfferDetailScreenState extends State<HotOfferDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text(
          'Christmas Offer',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: [
          SizedBox(
            height: 180,
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.navyBlue,
                image: const DecorationImage(
                  image: AssetImage(AppAssetImages.banner),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Text(
                'Expires on:04 Jan 2023, 23:59 PM',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.black.withOpacity(0.75),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Share
                  log("Share");
                },
                child: Row(
                  children: [
                    Text(
                      'Share',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.navyBlue,
                      ),
                    ),
                    const SizedBox(width: 1),
                    Image.asset(AppAssetImages.share)
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                'Christmas Offer',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Upto 50% Off',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Order pizzas now & win amazing prizes',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.black.withOpacity(0.75),
            ),
          ),
          const SizedBox(height: 27),
          DottedBorder(
            padding:
                const EdgeInsets.symmetric(horizontal: 58.5, vertical: 17.5),
            borderPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            color: AppColors.black,
            radius: const Radius.circular(6),
            child: Center(
              child: Text(
                'Coupan Code : MPK1986',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              InkWell(
                onTap: () {
                  log('Save');
                },
                child: Container(
                  width: size.width * 0.35,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: AppColors.navyBlue,
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  log('Visit Store Page');
                },
                child: Container(
                  width: size.width * 0.49,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: const Color.fromRGBO(244, 205, 69, 1),
                  ),
                  child: Center(
                    child: Text(
                      'Visit Store Page',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
          Text(
            'Steps To avail this offer',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Read About Store',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
