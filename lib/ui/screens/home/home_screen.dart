// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/components/ad_container.dart';
import 'package:nooow/ui/components/ad_marker.dart';
import 'package:nooow/ui/components/category_container.dart';
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
  late PageController _pageController;
  late TextEditingController _searchTextEditingController;
  late TextEditingController _subscribeTextEditingController;
  late FocusNode _searchFocus;
  late FocusNode _subscribeNode;
  late UIProvider _uiProvider;
  late ApiServiceProvider _apiServiceProvider;

  bool? isUserSignedIn = false;
  bool signedIn = false;
  int? dropDownValue = 0;
  int sliderIndex = 0;
  int offerIndex = 0;
  int index = 0;
  int _cuurentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _uiProvider = Provider.of<UIProvider>(context, listen: false);
    _apiServiceProvider =
        Provider.of<ApiServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _uiProvider.loaderTrue();
      await _async(context);
      _uiProvider.loaderFalse();
    });
    _automaticScroll();

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
    _timer?.cancel();
    super.dispose();
  }

  bool get isSignIn => (AppSharedPrefrence().userData == null ||
          AppSharedPrefrence().userData!.isEmpty)
      ? false
      : true;
  Future<void> _async(BuildContext context1) async {
    await AppSharedPrefrence().getCurrentPosition(context1);
    await _apiServiceProvider.slider(context1);
    await _apiServiceProvider.categoryList(context1);
    await _apiServiceProvider.offerListApi(context1);
    await _apiServiceProvider.topFoodBradListApi(context1);
  }

  Future<void> _automaticScroll() async {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) async {
      if (ApiServiceProvider().sliderList == null ||
          ApiServiceProvider().sliderList!.isEmpty) {
        null;
      } else {
        if (_cuurentIndex < ApiServiceProvider().sliderList!.length) {
          _cuurentIndex++;
        } else {
          _cuurentIndex = 0;
        }
        if (_pageController.hasClients) {
          await _pageController.animateToPage(_cuurentIndex,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<ApiServiceProvider>(
      builder: (context, apiServices, child) {
        return Scaffold(
          backgroundColor: AppColors.whiteBackground,
          drawer: AppDrawer(
            backgroundHeight: size.height * 0.18,
            isUserSignedIn: isSignIn,
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
          body: Consumer<UIProvider>(
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
                                            : AppColors.lightGrey,
                                      );
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
        );
      },
    );
  }
}
