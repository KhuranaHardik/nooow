import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nooow/provider/theme_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/screens/home/home_screen.dart';
import 'package:nooow/ui/screens/hot_offers/hot_offers_screen.dart';
import 'package:nooow/ui/screens/near_by/nearby_screens.dart';
import 'package:nooow/ui/screens/profile/profile_screen.dart';
import 'package:nooow/ui/screens/stores/stores_screen.dart';
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
    const NearByScreen(),
    const HotDealsScreen(),
    const StoresScreen(),
    const ProfileScreens(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer2<UIProvider, ThemeProvider>(
      builder: (context, uiProvider, themeProvider, child) {
        return WillPopScope(
          onWillPop: () async {
            if (_selectedIndex != 0) {
              setState(() {
                _selectedIndex = 0;
              });
              return false;
            } else {
              bool closeApp = await SystemChannels.platform
                  .invokeMethod('SystemNavigator.pop');
              return closeApp;
            }
          },
          child: Scaffold(
            body: _screens.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              // TODO:Colour change hoga is darkmode ke basis pr
              selectedItemColor: AppColors.black,
              unselectedItemColor: const Color.fromRGBO(122, 122, 122, 1),
              onTap: (index) {
                Provider.of<UIProvider>(context, listen: false).loaderFalse();
                _selectedIndex = uiProvider.onTap(index);
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssetImages.home)),
                  label: "HOME",
                ),

                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(AppAssetImages.nearBy),
                  ),
                  label: "NEAR BY",
                ),

                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssetImages.hot)),
                  label: "HOT",
                ),
                // Stores
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssetImages.stores)),
                  label: 'STORES',
                ),
                // Profile
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssetImages.profile)),
                  label: 'PROFILE',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
