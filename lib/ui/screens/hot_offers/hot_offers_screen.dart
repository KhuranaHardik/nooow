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
import 'package:nooow/ui/screens/hot_offers/components/hot_offers_card.dart';
import 'package:nooow/ui/screens/hot_offers/components/hot_offers_category.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:provider/provider.dart';

class HotDealsScreen extends StatefulWidget {
  const HotDealsScreen({super.key});

  @override
  State<HotDealsScreen> createState() => _HotDealsScreenState();
}

class _HotDealsScreenState extends State<HotDealsScreen> {
  late PageController _pageController;

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

      Provider.of<UIProvider>(context, listen: false).loaderFalse();
      _automaticScroll();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  bool get isSignIn => (AppSharedPrefrence().userData == null ||
          AppSharedPrefrence().userData!.isEmpty)
      ? false
      : true;

  Future<void> _automaticScroll() async {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) async {
      if (ApiServiceProvider().sliderList == null ||
          ApiServiceProvider().sliderList!.isEmpty) {
        null;
      } else {
        if (_cuurentIndex < ApiServiceProvider().sliderList!.length) {
          _cuurentIndex++;
        } else {
          _cuurentIndex = 0;
        }
        await _pageController.animateToPage(_cuurentIndex,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

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
            'Hot Offers',
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
        body: Consumer<UIProvider>(
          builder: (context, uiProvider, child) {
            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.only(bottom: 20),
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
                                  image: apiServices.sliderList?[index]
                                      ?['slider'],
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
                    GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 10,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 19,
                        mainAxisExtent: size.height * 0.30,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromRGBO(210, 210, 210, 1)),
                          ),
                          child: HotDealsOfferCard(
                            height: size.height,
                            saveOnTap: () {
                              log('Save');
                            },
                            seeDetailsOnTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.hotOfferDetailsScreen);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
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
      );
    });
  }
}
