import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/screens/hot_offers/components/hot_offers_card.dart';
import 'package:nooow/ui/screens/stores/components/flyer_card.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:provider/provider.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'My List',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: AppColors.white,
          ),
        ),
        actions: [
          // Stack(
          //   alignment: Alignment.topRight,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(top: 1),
          //       child: IconButton(
          //         onPressed: () {
          //           log('Favourites Pressed');
          //         },
          //         icon: const Icon(
          //           Icons.favorite_border_outlined,
          //           color: AppColors.white,
          //           size: 21,
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       top: 5,
          //       right: 2,
          //       child: CircleAvatar(
          //         radius: 10,
          //         backgroundColor: Colors.red,
          //         child: Center(
          //           child: Text(
          //             '0',
          //             style: GoogleFonts.montserrat(
          //               fontWeight: FontWeight.w600,
          //               fontSize: 9,
          //               color: AppColors.white,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
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
          return DefaultTabController(
            length: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              // height: size.height,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Color.fromRGBO(217, 217, 217, 1)),
                      ),
                    ),
                    child: TabBar(
                      labelColor: AppColors.black,
                      unselectedLabelColor: AppColors.black,
                      indicatorWeight: 5,
                      indicatorColor: AppColors.navyBlue,
                      labelStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      tabs: const [
                        // Tab(text: 'Flyers'),
                        Tab(text: 'Offers'),
                        Tab(text: 'Stores'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Offers
                        Stack(
                          children: [
                            GridView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: 10,
                              padding: const EdgeInsets.symmetric(vertical: 26),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 17,
                                crossAxisSpacing: 17,
                                mainAxisExtent: size.height * 0.28,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          210, 210, 210, 1),
                                    ),
                                  ),
                                  child: HotDealsOfferCard(height: size.height),
                                );
                              },
                            ),
                            uiProvider.loading
                                ? Container(
                                    height: size.height,
                                    color: AppColors.whiteBackground
                                        .withOpacity(0.4),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.navyBlue),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                        // Stores
                        Stack(
                          children: [
                            GridView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: 10,
                              padding: const EdgeInsets.symmetric(vertical: 26),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                mainAxisExtent: size.height * 0.33,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  // width: size.width * 0.42,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          210, 210, 210, 1),
                                    ),
                                  ),
                                  child: FlyersCard(height: size.height * 0.20),
                                );
                              },
                            ),
                            uiProvider.loading
                                ? Container(
                                    height: size.height,
                                    color: AppColors.whiteBackground
                                        .withOpacity(0.4),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.navyBlue),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
