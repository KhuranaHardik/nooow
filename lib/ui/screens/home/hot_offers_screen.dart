import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/ui/components/ad_container.dart';
import 'package:nooow/ui/components/ad_marker.dart';
import 'package:nooow/ui/components/hot_deals_screen/hot_deals_card.dart';
import 'package:nooow/ui/components/hot_deals_screen/hot_deals_category.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';

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
        // TODO: Notifications, favorites & search
        actions: const [],
      ),
      body: ListView(
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
          GridView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 19,
            ),
            itemBuilder: (context, index) {
              return HotDealsOfferCard(width: size.width);
            },
          ),
        ],
      ),
    );
  }
}
