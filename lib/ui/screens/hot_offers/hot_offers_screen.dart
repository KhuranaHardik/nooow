import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/components/ad_container.dart';
import 'package:nooow/ui/components/ad_marker.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
          Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: IconButton(
                  onPressed: () {
                    log('Favourites Pressed');
                    Navigator.pushNamed(context, AppRoutes.myListScreen);
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: AppColors.white,
                    size: 21,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 2,
                child: CircleAvatar(
                  radius: 10,
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
          IconButton(
            onPressed: () {
              log('Search Pressed');
            },
            icon: const Icon(Icons.search, size: 21),
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: IconButton(
                  onPressed: () {
                    log('Notifications Pressed');
                  },
                  icon: const Icon(
                    Icons.notifications_none,
                    size: 21,
                    color: AppColors.white,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 2,
                child: CircleAvatar(
                  radius: 10,
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
                            itemCount: 5,
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AdContainerWidget(
                                width: size.width,
                                // image: sliderList["information"][index]["slider"],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      mainAxisExtent: size.height * 0.28,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
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
  }
}
