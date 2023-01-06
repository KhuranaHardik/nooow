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
                                mainAxisExtent: size.height * 0.30,
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
