import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_strings.dart';

class AppConstants {
  final int statusCode = 201;
  final int statusCode2001 = 200;
  static const login = "login Successfully";
  static const logout = "logout Successfully";

// for checking null value
  bool checkStatusCode(status) {
    if (status == statusCode || status == statusCode2001) {
      return true;
    } else {
      return false;
    }
  }

  static List popularCategoriesList = [
    {
      AppString.categoryName: AppString.fashion,
      AppString.categoryImage: AppAssetImages.fashion,
    },
    {
      AppString.categoryName: AppString.beauty,
      AppString.categoryImage: AppAssetImages.beauty,
    },
    {
      AppString.categoryName: AppString.beauty,
      AppString.categoryImage: AppAssetImages.beauty,
    },
    {
      AppString.categoryName: AppString.grocery,
      AppString.categoryImage: AppAssetImages.grocery,
    },
    {
      AppString.categoryName: AppString.movies,
      AppString.categoryImage: AppAssetImages.movies,
    },
    {
      AppString.categoryName: AppString.pharmacy,
      AppString.categoryImage: AppAssetImages.pharmacy,
    },
    {
      AppString.categoryName: AppString.fashion,
      AppString.categoryImage: AppAssetImages.fashion,
    },
    {
      AppString.categoryName: AppString.grocery,
      AppString.categoryImage: AppAssetImages.beauty,
    },
  ];
}
