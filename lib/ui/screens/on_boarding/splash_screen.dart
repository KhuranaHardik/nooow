import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:nooow/utils/app_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double appBarHeight = AppBar().preferredSize.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.whiteBackground,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppColors.whiteBackground),
        ),
        backgroundColor: AppColors.whiteBackground,
        body: Container(
          width: size.width,
          height: size.height,
          margin: EdgeInsets.only(
            left: 54,
            right: 54,
            top: 197 - appBarHeight,
            bottom: 86,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssetImages.appLogo),
              const Text(AppString.offersDealAroundYou),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.signInScreen, (route) => true);
                },
                child: Container(
                  height: 62,
                  width: 62,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.navyBlue,
                  ),
                  child: Center(
                    child: Image.asset(AppAssetImages.arrowRight),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
