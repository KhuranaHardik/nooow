import 'package:flutter/material.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class OffersContainerWidget extends StatelessWidget {
  const OffersContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 137,
      width: 138.23,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: AppColors.whiteBackground,
        image: const DecorationImage(
          // TODO: Update offer image from the API
          image: AssetImage(AppAssetImages.offers),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
