// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:nooow/provider/theme_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:provider/provider.dart';

class TileCardWidget extends StatefulWidget {
  bool isThemeButton = false;
  Function()? onTap;
  String name;
  String icon;
  bool isLogOutButton = false;
  TileCardWidget({
    super.key,
    required this.isThemeButton,
    required this.onTap,
    required this.name,
    required this.icon,
    required this.isLogOutButton,
  });

  @override
  State<TileCardWidget> createState() => _TileCardWidgetState();
}

class _TileCardWidgetState extends State<TileCardWidget> {
  bool isSwitchOn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String? theme = await AppSharedPrefrence().getTheme();
      isSwitchOn = (theme == 'light' || theme == null) ? false : true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UIProvider, ThemeProvider>(
      builder: (context, uiProvider, themeProvider, child) {
        return InkWell(
          onTap: widget.onTap,
          child: Card(
            color: AppColors.drawerListItemColor,
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.navyBlue,
                child: Image.asset(
                  widget.icon,
                  color: widget.isLogOutButton
                      ? AppColors.notificationsColor
                      : AppColors.white,
                  width: 15,
                  height: 15,
                ),
              ),
              title: Text(widget.name),
              trailing: widget.isThemeButton
                  ? Switch.adaptive(
                      activeColor: AppColors.navyBlue,
                      value: isSwitchOn,
                      onChanged: (val) {
                        uiProvider.loaderTrue();
                        isSwitchOn = uiProvider.updateSwitch(isSwitchOn);
                        isSwitchOn
                            ? themeProvider.setDarkMode()
                            : themeProvider.setLightMode();
                        uiProvider.loaderFalse();
                      },
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
