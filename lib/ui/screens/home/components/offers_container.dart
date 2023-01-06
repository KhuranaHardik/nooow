import 'package:flutter/material.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class OffersContainerWidget extends StatelessWidget {
  final String? image;
  const OffersContainerWidget({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 138.23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: AppColors.whiteBackground,
        border: Border.all(color: AppColors.grey.withOpacity(0.4)),
        image: DecorationImage(
          image: (image == null || image!.isEmpty)
              ? const AssetImage(AppAssetImages.offers) as ImageProvider
              : NetworkImage(image!),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
