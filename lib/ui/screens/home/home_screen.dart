// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/components/ad_container.dart';
import 'package:nooow/ui/components/ad_marker.dart';
import 'package:nooow/ui/components/category_container.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/ui/components/custom_text_form_field.dart';
import 'package:nooow/ui/components/drawer.dart';
import 'package:nooow/ui/screens/home/components/food_brand_widget.dart';
import 'package:nooow/ui/screens/home/components/offers_container.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:nooow/utils/app_strings.dart';
import 'package:provider/provider.dart';

import '../../../provider/api_services_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppSharedPrefrence _appSharedPrefrence;
  late PageController _pageController;
  late TextEditingController _searchTextEditingController;
  late TextEditingController _subscribeTextEditingController;
  late FocusNode _searchFocus;
  late FocusNode _subscribeNode;

  bool? isUserSignedIn = false;
  bool signedIn = false;
  int? dropDownValue = 0;
  int sliderIndex = 0;
  int offerIndex = 0;
  int index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<UIProvider>(context, listen: false).loaderTrue();
      ApiServiceProvider apiServiceProvider =
          Provider.of<ApiServiceProvider>(context, listen: false);
      await apiServiceProvider.slider(context);
      await apiServiceProvider.categoryList(context);
      await apiServiceProvider.offerListApi(context);
      await apiServiceProvider.topFoodBradListApi(context);
      isUserSignedIn = await _appSharedPrefrence.getUserSignedIn();

      log(isUserSignedIn.toString());
      Provider.of<UIProvider>(context, listen: false).loaderFalse();
    });
    _appSharedPrefrence = AppSharedPrefrence();
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

  bool get isSignIn => isUserSignedIn ?? false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<ApiServiceProvider>(
      builder: (context, apiServices, child) {
        return Scaffold(
          backgroundColor: AppColors.whiteBackground,
          drawer: drawer(
            context: context,
            isUserSignedIn: isSignIn,
            backgroundHeight: size.height * 0.18,
          ),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            foregroundColor: AppColors.black,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemStatusBarContrastEnforced: true,
            ),
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssetImages.homePlace,
                  color: AppColors.black,
                  height: 17,
                  width: 17,
                ),
                const SizedBox(width: 3),
                DropdownButton(
                  value: dropDownValue,
                  onChanged: (val) {
                    setState(() {
                      dropDownValue = val;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Delhi'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Noida'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Bareilly'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Chandigarh'),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text('Jalandhar'),
                    ),
                    DropdownMenuItem(
                      value: 5,
                      child: Text(
                        'Shahjahanpur',
                      ),
                    ),
                  ],
                  underline: const SizedBox(height: 0),
                ),
              ],
            ),
            actions: [
              // Favorites
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.myListScreen);
                },
                child: SizedBox(
                  width: 26,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 17, right: 6),
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: AppColors.black,
                          size: 22,
                        ),
                      ),
                      Positioned(
                        top: 12,
                        // right: 2,
                        left: 12,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.red,
                          child: Center(
                            child: Text(
                              '0',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 9,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Notifications
              InkWell(
                onTap: () {
                  log('Notifications');
                },
                child: SizedBox(
                  width: 26,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 17, right: 6),
                        child: Icon(
                          Icons.notifications_none,
                          color: AppColors.black,
                          size: 22,
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.red,
                          child: Center(
                            child: Text(
                              '0',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 9,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 2)
            ],
            elevation: 0.0,
            backgroundColor: AppColors.whiteBackground,
          ),
          body: WillPopScope(
            onWillPop: () async {
              bool closeApp = await SystemChannels.platform
                  .invokeMethod('SystemNavigator.pop');
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
                          // Advertisements
                          SizedBox(
                            height: 180,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 160,
                                  child: PageView.builder(
                                    itemCount: apiServices.sliderList?.length,
                                    onPageChanged: (value) {
                                      setState(() {
                                        index = value;
                                      });
                                    },
                                    controller: _pageController,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return AdContainerWidget(
                                        width: size.width - 42,
                                        image: apiServices.sliderList?[index]
                                            ?['slider'],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 21.0),
                                  child: Row(
                                    children: List.generate(
                                      apiServices.sliderList?.length ?? 0,
                                      (i) {
                                        return AdMarkerWidget(
                                            color: index == i
                                                ? AppColors.navyBlue
                                                : AppColors.lightGrey);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 26),

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
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 18.38,
                            runSpacing: 17,
                            children: List.generate(
                              apiServices.categorylist?.length ?? 0,
                              (index) => CategoryContainerWidget(
                                categoryName: apiServices.categorylist?[index]
                                    ?['title'],
                                categoryImage: apiServices.categorylist?[index]
                                    ?['image'],
                                width: size.width * 0.188,
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
                            child: ListView.builder(
                              itemCount: apiServices.offerList?.length ?? 0,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: OffersContainerWidget(
                                    image: apiServices.offerList?[index]
                                        ?['image'],
                                  ),
                                );
                              },
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
                                apiServices.topFoodBrandList?.length ?? 0,
                                (index) => FoodBrandWidget(
                                  image: null,
                                  offerPercentage:
                                      apiServices.topFoodBrandList?[index]
                                          ?['offer_percentage'],
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
                                      controller:
                                          _subscribeTextEditingController,
                                      focusNode: _subscribeNode,
                                      textInputAction: TextInputAction.done,
                                      readOnly: false,
                                      placeholder:
                                          AppString.enterEmailAddressHere,
                                      borderColor: AppColors.navyBlue,
                                      isObscure: false,
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
                    uiProvider.loading
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
      },
    );
  }

  // Widget drawer({
  //   required BuildContext context,
  //   // required bool? isUserSignedIn,
  //   required double backgroungHeight,
  // }) {
  //   // bool signedIn = isUserSignedIn ?? false;
  //   return Drawer(
  //     elevation: 0.0,
  //     child: ListView(
  //       children: [
  //         Container(
  //           height: backgroungHeight,
  //           padding: const EdgeInsets.only(top: 36, bottom: 30, left: 22),
  //           decoration: const BoxDecoration(
  //             color: AppColors.navyBlue,
  //             borderRadius: BorderRadius.only(topRight: Radius.circular(8.0)),
  //           ),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               const CircleAvatar(radius: 24),
  //               const SizedBox(width: 10),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     isUserSignedIn ?? false
  //                         ? AppString.userName
  //                         : AppString.signInSignUp,
  //                     style: GoogleFonts.poppins(
  //                       fontWeight: FontWeight.w500,
  //                       color: AppColors.white,
  //                       fontSize: 14,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(left: 17.5, right: 17.5, top: 24),
  //           child: Column(
  //             children: [
  //               // Settings
  //               DrawerListTile(
  //                 iconPath: AppAssetImages.settings,
  //                 tileTitle: AppString.settings,
  //                 isDropDown: true,
  //                 onTap: () {},
  //               ),
  //               const SizedBox(height: 11),
  //               // Privacy & Policy
  //               DrawerListTile(
  //                 iconPath: AppAssetImages.drawerPrivacyPolicy,
  //                 tileTitle: AppString.privacyAndPolicy,
  //                 isDropDown: false,
  //                 onTap: () {},
  //               ),
  //               const SizedBox(height: 11),
  //               // Refer To Friends
  //               DrawerListTile(
  //                 iconPath: AppAssetImages.share,
  //                 tileTitle: AppString.referToFriends,
  //                 isDropDown: false,
  //                 onTap: () {},
  //               ),
  //               const SizedBox(height: 11),
  //               // Logout
  //               isUserSignedIn ?? false
  //                   ? DrawerListTile(
  //                       iconPath: AppAssetImages.drawerLogOut,
  //                       tileTitle: AppString.logout,
  //                       isDropDown: false,
  //                       onTap: () async {
  //                         await showDialog(
  //                           context: context,
  //                           builder: (context) {
  //                             return AlertDialog(
  //                               title: const Text(AppString.areYouSureToLogout),
  //                               actions: [
  //                                 IconButton(
  //                                   onPressed: () async {
  //                                     SharedPreferences pref =
  //                                         await SharedPreferences.getInstance();
  //                                     if (await pref.clear()) {
  //                                       await AppSharedPrefrence()
  //                                           .setUserSignedIn(false);
  //                                       Navigator.pushNamedAndRemoveUntil(
  //                                           context,
  //                                           AppRoutes.signInScreen,
  //                                           (route) => false);
  //                                     }
  //                                   },
  //                                   icon: const Text(AppString.yes),
  //                                 ),
  //                                 IconButton(
  //                                   onPressed: () => Navigator.pop(context),
  //                                   icon: const Text(AppString.no),
  //                                 ),
  //                               ],
  //                             );
  //                           },
  //                         );
  //                       },
  //                     )
  //                   : DrawerListTile(
  //                       iconPath: AppAssetImages.profile,
  //                       tileTitle: AppString.signInSignUp,
  //                       isDropDown: false,
  //                       onTap: () {
  //                         Navigator.pop(context);
  //                         Navigator.pushNamed(
  //                           context,
  //                           AppRoutes.signInScreen,
  //                         );
  //                       },
  //                     ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
