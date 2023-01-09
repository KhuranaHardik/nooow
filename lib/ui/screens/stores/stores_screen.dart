// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/components/ad_container.dart';
import 'package:nooow/ui/components/ad_marker.dart';
import 'package:nooow/ui/components/drawer.dart';
import 'package:nooow/ui/screens/hot_offers/components/hot_offers_category.dart';
import 'package:nooow/ui/screens/stores/components/stores_card.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:provider/provider.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  late PageController _pageController;
  final ApiServiceProvider apiServices = ApiServiceProvider();

  bool signedIn = false;
  int sliderIndex = 0;
  int index = 0;
  int _cuurentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<UIProvider>(context, listen: false).loaderTrue();

      ApiServiceProvider apiServiceProvider =
          Provider.of<ApiServiceProvider>(context, listen: false);
      await ApiServiceProvider().getCurrentPosition(context);
      await apiServiceProvider.ventorSliderListApi(
        context,
      );

      Provider.of<UIProvider>(context, listen: false).loaderFalse();
    });
    _automaticScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _automaticScroll() async {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) async {
      if (ApiServiceProvider().vendorSliderList == null ||
          ApiServiceProvider().vendorSliderList!.isEmpty) {
        null;
      } else {
        if (_cuurentIndex < ApiServiceProvider().vendorSliderList!.length) {
          _cuurentIndex++;
        } else {
          _cuurentIndex = 0;
        }
        await _pageController.animateToPage(_cuurentIndex,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

  bool get isSignIn => (AppSharedPrefrence().userData == null ||
          AppSharedPrefrence().userData!.isEmpty)
      ? false
      : true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<ApiServiceProvider>(builder: (context, apiServices, child) {
      return Scaffold(
        drawer: AppDrawer(
          isUserSignedIn: isSignIn,
          backgroundHeight: size.height * 0.18,
        ),
        appBar: AppBar(
          backgroundColor: AppColors.navyBlue,
          elevation: 0.0,
          title: Text(
            'Top Stores',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: AppColors.white,
            ),
          ),
          actions: [
            // Favorites
            InkWell(
              onTap: () {
                !isSignIn
                    ? Navigator.pushNamed(context, AppRoutes.signInScreen)
                    : Navigator.pushNamed(context, AppRoutes.myListScreen);
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
                        color: AppColors.white,
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
                !isSignIn
                    ? Navigator.pushNamed(context, AppRoutes.signInScreen)
                    : log('Notifications');
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
                        color: AppColors.white,
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
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 19),
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
                              image: apiServices.sliderList?[index]?['slider'],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 14),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21.0),
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
                const SizedBox(height: 28),
                // Categories
                SizedBox(
                  height: 54,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    children: const [
                      HotDealsCategoryWidget(
                        isSelected: true,
                        categoryImage: AppAssetImages.mostPopular,
                        categoryName: "Most Popular",
                      ),
                      SizedBox(width: 15),
                      HotDealsCategoryWidget(
                        isSelected: false,
                        categoryImage: AppAssetImages.travel,
                        categoryName: "Travel",
                      ),
                      SizedBox(width: 15),
                      HotDealsCategoryWidget(
                        isSelected: false,
                        categoryImage: AppAssetImages.fashion,
                        categoryName: "Fashion",
                      ),
                      SizedBox(width: 15),
                      HotDealsCategoryWidget(
                        isSelected: false,
                        categoryImage: AppAssetImages.food,
                        categoryName: "Food",
                      ),
                      SizedBox(width: 15),
                      HotDealsCategoryWidget(
                        isSelected: false,
                        categoryImage: AppAssetImages.electronic,
                        categoryName: "Electronic",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<UIProvider>(
                  builder: (context, uiProvider, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.5),
                      child: GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: apiServices.vendorSliderList?.length ?? 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 17,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.storeDetailScreen,
                                  arguments: {
                                    'id': apiServices.vendorSliderList?[index]
                                        ?['vendor'],
                                    'storeName': apiServices
                                        .vendorSliderList?[index]?['title']
                                  });
                            },
                            child: StoresCard(
                              width: size.width * 0.42,
                              image: apiServices.vendorSliderList?[index]
                                  ?['slider'],
                              flyers: '4',
                              offers: '5',
                              companyName: apiServices.vendorSliderList?[index]
                                  ?['title'],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
            Consumer<UIProvider>(
                builder: (context, uiProvider, child) => uiProvider.loading
                    ? Container(
                        width: size.width,
                        height: size.height,
                        color: AppColors.white.withOpacity(0.8),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.navyBlue,
                          ),
                        ))
                    : const SizedBox.shrink())
          ],
        ),
      );
    });
  }
}
