// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/api_services.dart';
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
import 'package:nooow/utils/app_routes.dart';
import 'package:nooow/utils/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late TextEditingController _searchTextEditingController;
  late TextEditingController _subscribeTextEditingController;
  late FocusNode _searchFocus;
  late FocusNode _subscribeNode;
  Map<String, dynamic>? _sliderList = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _sliderList = await ApiServices().sliderList(context);
    });
    _pageController = PageController();
    _searchTextEditingController = TextEditingController();
    _subscribeTextEditingController = TextEditingController();
    _searchFocus = FocusNode();
    _subscribeNode = FocusNode();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchTextEditingController.dispose();
    _subscribeTextEditingController.dispose();
    _searchFocus.dispose();
    _subscribeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Are you sure to logout?'),
                      actions: [
                        IconButton(
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              if (await pref.clear()) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    AppRoutes.signInScreen, (route) => false);
                              }
                            },
                            icon: const Text('Yes')),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Text('No')),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.red,
              ))
        ],
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
      body: WillPopScope(
        onWillPop: () async {
          bool closeApp =
              await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return closeApp;
        },
        child: Consumer<UIProvider>(
          builder: (context, uiProvider, child) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    _searchFocus.unfocus();
                    _subscribeNode.unfocus();
                  },
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 56),
                    primary: true,
                    children: [
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: CustomTextField(
                          controller: _searchTextEditingController,
                          focusNode: _searchFocus,
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
                                controller: _pageController,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return AdContainerWidget(
                                    width: size.width - 42,
                                    // image: sliderList["information"][index]["slider"],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 14),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 21.0),
                              child: Row(
                                children: List.generate(
                                  5,
                                  (index) {
                                    return const AdMarkerWidget(
                                        color: AppColors.lightGrey);
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
                              categoryName:
                                  AppConstants.popularCategoriesList[index]
                                      [AppString.categoryName],
                              categoryImage:
                                  AppConstants.popularCategoriesList[index]
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
                              return const AdMarkerWidget(
                                  color: AppColors.lightGrey);
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
                                  focusNode: _subscribeNode,
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
                ),
                // Loading Screen
                uiProvider.loader == true
                    ? Container(
                        height: size.height,
                        color: AppColors.whiteBackground.withOpacity(0.4),
                        child: const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.navyBlue),
                        ),
                      )
                    : const SizedBox()
              ],
            );
          },
        ),
      ),
    );
  }
}
