import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/ui/components/ad_container.dart';
import 'package:nooow/ui/components/ad_marker.dart';
import 'package:nooow/ui/components/category_container.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/ui/components/custom_text_form_field.dart';
import 'package:nooow/ui/components/food_brand_widget.dart';
import 'package:nooow/ui/components/offers_container.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_constants.dart';
import 'package:nooow/utils/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;
  late TextEditingController _searchTextEditingController;
  late TextEditingController _subscribeTextEditingController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _searchTextEditingController = TextEditingController();
    _subscribeTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    pageController.dispose();
    _searchTextEditingController.dispose();
    _subscribeTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
        ),
        elevation: 0.0,
        backgroundColor: AppColors.whiteBackground,
        title: Row(
          children: [
            Image.asset(
              AppAssetImages.appLogo,
              height: 22,
            ),
            const Spacer(),
            Image.asset(AppAssetImages.place),
            const SizedBox(width: 4),
            Text(
              AppString.tempLocation,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: AppColors.navyBlue,
              ),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 56),
        primary: true,
        children: [
          const SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: CustomTextField(
              controller: _searchTextEditingController,
              isObscure: false,
              readOnly: false,
              textInputAction: TextInputAction.done,
              placeholder: AppString.searchForItems,
            ),
          ),
          const SizedBox(height: 17),
          // Advertisements
          SizedBox(
            height: 180,
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  child: PageView.builder(
                    itemCount: 5,
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return AdContainerWidget(width: size.width - 42);
                    },
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21.0),
                  child: Row(
                    children: List.generate(
                      5,
                      (index) {
                        return const AdMarkerWidget(color: AppColors.lightGrey);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 26),
          // Popular Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Text(
              AppString.popularCategories,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Popular Categories
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 18.38,
              runSpacing: 17,
              children: List.generate(
                AppConstants.popularCategoriesList.length,
                (index) => CategoryContainerWidget(
                  categoryName: AppConstants.popularCategoriesList[index]
                      [AppString.categoryName],
                  categoryImage: AppConstants.popularCategoriesList[index]
                      [AppString.categoryImage],
                  width: size.width * 0.188,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Offers you will love
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Text(
              AppString.offersYouWillLove,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 17),
          // Offers you will love
          Container(
            height: 137,
            margin: const EdgeInsets.symmetric(horizontal: 21),
            child: ListView(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: const [
                OffersContainerWidget(),
                SizedBox(width: 18.06),
                OffersContainerWidget(),
                SizedBox(width: 18.06),
                OffersContainerWidget(),
                SizedBox(width: 18.06),
                OffersContainerWidget(),
                SizedBox(width: 18.06),
                OffersContainerWidget(),
              ],
            ),
          ),
          const SizedBox(height: 17),
          // Markers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Row(
              children: List.generate(
                5,
                (index) {
                  return const AdMarkerWidget(color: AppColors.lightGrey);
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Top Food Brands
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Text(
              AppString.topFoodBrands,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 17),
          // Top Food Brands
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 21),
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 18.38,
              runSpacing: 12,
              children: List.generate(
                5,
                (index) => FoodBrandWidget(
                  width: size.width * 0.26,
                ),
              ),
            ),
          ),
          const SizedBox(height: 37),
          // Top food brands
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Text(
              AppString.topFoodBrands,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 23),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 18.38,
              runSpacing: 17,
              children: List.generate(
                5,
                (index) => FoodBrandWidget(
                  width: size.width * 0.26,
                ),
              ),
            ),
          ),
          const SizedBox(height: 38),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Container(
              width: size.width - 42,
              padding: const EdgeInsets.only(
                left: 17,
                right: 17,
                top: 13,
                bottom: 31,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.lightBlue,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssetImages.hotDeals,
                        height: 22,
                      ),
                      const SizedBox(width: 7.67),
                      Text(
                        AppString.cashbackVoucherReviews,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AppString.getLatestOffersNews,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: CustomTextField(
                      controller: _subscribeTextEditingController,
                      textInputAction: TextInputAction.done,
                      isObscure: false,
                      readOnly: false,
                      placeholder: AppString.enterEmailAddressHere,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomElevatedButton(
                    elevation: 0.0,
                    borderRadius: 11,
                    buttonSize: Size(size.width, 60),
                    buttonColor: AppColors.navyBlue,
                    onPressed: () {},
                    borderColor: AppColors.transparent,
                    child: Text(
                      AppString.submit,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
