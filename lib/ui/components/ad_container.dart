import 'package:flutter/material.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

class AdContainerWidget extends StatelessWidget {
  final String? image;
  final double width;
  final bool isDarkMode;

  const AdContainerWidget({
    Key? key,
    this.image,
    required this.width,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 21),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // TODO:Colour change hoga is darkmode ke basis pr
        color: AppColors.navyBlue,
        image: DecorationImage(
          image: image == null
              ? const AssetImage(AppAssetImages.appLogo)
              : NetworkImage(image!) as ImageProvider,
          fit: image == null ? null : BoxFit.fill,
        ),
      ),
    );
  }
}
