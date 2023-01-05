import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/components/ad_container.dart';
import 'package:nooow/ui/components/ad_marker.dart';
import 'package:nooow/ui/screens/hot_offers/components/hot_offers_category.dart';
import 'package:nooow/ui/screens/stores/components/stores_card.dart';
import 'package:nooow/ui/screens/stores/stores_details_screen.dart';
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
          'Top Stores',
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
      body: ListView(
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
                        return const AdMarkerWidget(color: AppColors.lightGrey);
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
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 17,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StoresDetailScreen(),
                          ),
                        );
                      },
                      child: StoresCard(width: size.width * 0.42),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
