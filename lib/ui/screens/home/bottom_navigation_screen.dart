import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/screens/home/home_screen.dart';
import 'package:nooow/ui/screens/home/hot_offers_screen.dart';
import 'package:nooow/ui/screens/home/nearby_screens.dart';
import 'package:nooow/ui/screens/home/profile_screen.dart';
import 'package:nooow/ui/screens/home/stores_screen.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:provider/provider.dart';

//Bottom Navigation Bar in the app.
class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;
  final List _screens = [
    const HomeScreen(),
    const NearByScreens(),
    const HotDealsScreen(),
    const StoresScreen(),
    const ProfileScreens(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<UIProvider>(
      builder: (context, uiProvider, child) {
        return Scaffold(
          body: _screens.elementAt(_selectedIndex),
          bottomNavigationBar: Container(
            //Shadow of Bottom Navigation Bar
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.04),
                  blurRadius: 22.0,
                  offset: Offset(0, -9),
                  spreadRadius: 0,
                )
              ],
            ),

            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: AppColors.black,
              unselectedItemColor: const Color.fromRGBO(122, 122, 122, 1),
              onTap: (index) {
                _selectedIndex = uiProvider.onTap(index);
              },
              items: <BottomNavigationBarItem>[
                // Home
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Image.asset(
                        AppAssetImages.home,
                        width: 18,
                        height: 18,
                        color: _selectedIndex == 0
                            ? AppColors.black
                            : const Color.fromRGBO(122, 122, 122, 1),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "HOME",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: _selectedIndex == 0
                              ? AppColors.black
                              : const Color.fromRGBO(122, 122, 122, 1),
                        ),
                      )
                    ],
                  ),
                  label: '',
                ),
                // Near By
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Image.asset(
                        AppAssetImages.nearBy,
                        width: 18,
                        height: 18,
                        color: _selectedIndex == 1
                            ? AppColors.black
                            : const Color.fromRGBO(122, 122, 122, 1),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "NEAR BY",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: _selectedIndex == 1
                              ? AppColors.black
                              : const Color.fromRGBO(122, 122, 122, 1),
                        ),
                      )
                    ],
                  ),
                  label: '',
                ),
                // Hot
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Image.asset(
                        AppAssetImages.hot,
                        width: 18,
                        height: 18,
                        color: _selectedIndex == 2
                            ? AppColors.black
                            : const Color.fromRGBO(122, 122, 122, 1),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "HOT",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: _selectedIndex == 2
                              ? AppColors.black
                              : const Color.fromRGBO(122, 122, 122, 1),
                        ),
                      )
                    ],
                  ),
                  label: '',
                ),
                // Stores
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Image.asset(
                        AppAssetImages.stores,
                        width: 18,
                        height: 18,
                        color: _selectedIndex == 3
                            ? AppColors.black
                            : const Color.fromRGBO(122, 122, 122, 1),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "STORES",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: _selectedIndex == 3
                              ? AppColors.black
                              : const Color.fromRGBO(122, 122, 122, 1),
                        ),
                      )
                    ],
                  ),
                  label: '',
                ),
                // Profile
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Image.asset(
                        AppAssetImages.profile,
                        width: 18,
                        height: 18,
                        color: _selectedIndex == 4
                            ? AppColors.black
                            : const Color.fromRGBO(122, 122, 122, 1),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "PROFILE",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: _selectedIndex == 4
                              ? AppColors.black
                              : const Color.fromRGBO(122, 122, 122, 1),
                        ),
                      )
                    ],
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
