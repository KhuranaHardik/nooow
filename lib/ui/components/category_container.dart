import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class CategoryContainerWidget extends StatelessWidget {
  final String categoryName;
  final String categoryImage;
  final double width;

  const CategoryContainerWidget({
    Key? key,
    required this.categoryName,
    required this.categoryImage,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Container(
            height: 73.53,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.lighterGrey,
              image: DecorationImage(
                  image: (categoryImage.isEmpty)
                      ? const AssetImage(AppAssetImages.appLogo)
                          as ImageProvider
                      : NetworkImage(categoryImage),
                  fit: BoxFit.contain),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 15.6, horizontal: 14.2),
          ),
          const SizedBox(height: 9.47),
          Text(
            categoryName,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
