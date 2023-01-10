import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class CategoryContainerWidget extends StatelessWidget {
  final String categoryName;
  final String categoryImage;

  const CategoryContainerWidget({
    Key? key,
    required this.categoryName,
    required this.categoryImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: AppColors.transparent,
        margin: const EdgeInsets.only(right: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: AppColors.lighterGrey,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: AppColors.lighterGrey,
                  image: DecorationImage(
                      image: (categoryImage.isEmpty)
                          ? const AssetImage(
                              AppAssetImages.appLogo,
                            ) as ImageProvider
                          : NetworkImage(categoryImage),
                      fit: BoxFit.fill),
                ),
              ),
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
      ),
    );
  }
}
