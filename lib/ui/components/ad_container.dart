import 'package:flutter/material.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class AdContainerWidget extends StatelessWidget {
  final String? image;
  final double width;

  const AdContainerWidget({
    Key? key,
    this.image,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 21),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.navyBlue,
        image: const DecorationImage(
          // TODO: Update offer image from the API
          image: AssetImage(AppAssetImages.appLogo),
        ),
      ),
    );
  }
}
