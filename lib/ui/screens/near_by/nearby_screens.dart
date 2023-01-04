import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_colors.dart';

class NearByScreen extends StatefulWidget {
  const NearByScreen({super.key});

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'Nearby',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: AppColors.white,
          ),
        ),
        // TODO: Notifications, favorites & search
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: IconButton(
                  onPressed: () {
                    log('Favourites Pressed');
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
        padding:
            const EdgeInsets.only(top: 18, bottom: 30, left: 21, right: 19),
        children: [
          Container(
            height: 395,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text('Map'),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "Selected Location",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Bhangel, Greater Noida, 201306",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
